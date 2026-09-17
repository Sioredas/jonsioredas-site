// House photo grade for jonsioredas-site.
// usage: grade <in> <out> <width> <EV> <gainR> <gainG> <gainB> <contrast> <saturation> [grain]
import Foundation
import CoreImage
import AppKit

let a = CommandLine.arguments
let inURL = URL(fileURLWithPath: a[1]), outURL = URL(fileURLWithPath: a[2])
let targetW = CGFloat(Double(a[3])!)
let ev = Double(a[4])!, gR = Double(a[5])!, gG = Double(a[6])!, gB = Double(a[7])!
let kContrast = Double(a[8])!, sImg = Double(a[9])!
let grainAmp = a.count > 10 ? Double(a[10])! : 0.025

func clamp(_ x: Double) -> Double { min(max(x, 0), 1) }
func toLin(_ c: Double) -> Double { c <= 0.04045 ? c / 12.92 : pow((c + 0.055) / 1.055, 2.4) }
func toSRGB(_ c: Double) -> Double { c <= 0.0031308 ? c * 12.92 : 1.055 * pow(c, 1 / 2.4) - 0.055 }

// Per-image normalization + shared house look, evaluated in sRGB-encoded space.
func look(_ r0: Double, _ g0: Double, _ b0: Double) -> (Double, Double, Double) {
  // 1) exposure + white balance in linear light
  let m = pow(2.0, ev)
  var r = toSRGB(clamp(toLin(r0) * m * gR)), g = toSRGB(clamp(toLin(g0) * m * gG)), b = toSRGB(clamp(toLin(b0) * m * gB))
  // 2) per-image contrast around mid-gray
  r = clamp(0.5 + (r - 0.5) * kContrast); g = clamp(0.5 + (g - 0.5) * kContrast); b = clamp(0.5 + (b - 0.5) * kContrast)
  // 3) per-image saturation
  var y = 0.2126 * r + 0.7152 * g + 0.0722 * b
  r = clamp(y + (r - y) * sImg); g = clamp(y + (g - y) * sImg); b = clamp(y + (b - y) * sImg)
  // 4) house look: filmic S-curve, lifted blacks, softened whites
  func curve(_ c: Double) -> Double { let s = c + 0.28 * c * (1 - c) * (2 * c - 1); return 0.03 + 0.944 * s }
  r = curve(r); g = curve(g); b = curve(b)
  // 5) house saturation
  y = 0.2126 * r + 0.7152 * g + 0.0722 * b
  r = y + (r - y) * 0.88; g = y + (g - y) * 0.88; b = y + (b - y) * 0.88
  // 6) split tone: Poly Green shadows, warm gold highlights
  let ws = pow(1 - y, 2) * 0.085, wh = pow(y, 2) * 0.075
  r += ws * -0.30 + wh * 0.34
  g += ws *  0.26 + wh * 0.14
  b += ws *  0.06 + wh * -0.36
  return (clamp(r), clamp(g), clamp(b))
}

let N = 33
var cube = [Float](repeating: 0, count: N * N * N * 4)
for bi in 0..<N { for gi in 0..<N { for ri in 0..<N {
  let (r, g, b) = look(Double(ri) / Double(N - 1), Double(gi) / Double(N - 1), Double(bi) / Double(N - 1))
  let i = ((bi * N + gi) * N + ri) * 4
  cube[i] = Float(r); cube[i + 1] = Float(g); cube[i + 2] = Float(b); cube[i + 3] = 1
}}}
let srgb = CGColorSpace(name: CGColorSpace.sRGB)!
guard var img = CIImage(contentsOf: inURL, options: [.applyOrientationProperty: true]) else { print("cannot open \(inURL.path)"); exit(1) }
let lut = CIFilter(name: "CIColorCubeWithColorSpace")!
lut.setValue(img, forKey: kCIInputImageKey)
lut.setValue(N, forKey: "inputCubeDimension")
lut.setValue(cube.withUnsafeBufferPointer { Data(buffer: $0) }, forKey: "inputCubeData")
lut.setValue(srgb, forKey: "inputColorSpace")
img = lut.outputImage!

// resize
let scale = targetW / img.extent.width
let rs = CIFilter(name: "CILanczosScaleTransform")!
rs.setValue(img, forKey: kCIInputImageKey); rs.setValue(scale, forKey: kCIInputScaleKey); rs.setValue(1.0, forKey: kCIInputAspectRatioKey)
img = rs.outputImage!.cropped(to: CGRect(x: 0, y: 0, width: targetW.rounded(), height: (img.extent.height * scale).rounded()))

// gentle vignette
let vg = CIFilter(name: "CIVignette")!
vg.setValue(img, forKey: kCIInputImageKey); vg.setValue(0.32, forKey: kCIInputIntensityKey); vg.setValue(1.6, forKey: kCIInputRadiusKey)
img = vg.outputImage!.cropped(to: img.extent)

// fine monochrome grain via soft light
if grainAmp > 0 {
  let noise = CIFilter(name: "CIRandomGenerator")!.outputImage!.cropped(to: img.extent)
  let mono = CIFilter(name: "CIColorControls")!
  mono.setValue(noise, forKey: kCIInputImageKey); mono.setValue(0.0, forKey: kCIInputSaturationKey)
  let amp = CGFloat(grainAmp)
  let mapped = CIFilter(name: "CIColorMatrix")!
  mapped.setValue(mono.outputImage!, forKey: kCIInputImageKey)
  mapped.setValue(CIVector(x: amp, y: 0, z: 0, w: 0), forKey: "inputRVector")
  mapped.setValue(CIVector(x: 0, y: amp, z: 0, w: 0), forKey: "inputGVector")
  mapped.setValue(CIVector(x: 0, y: 0, z: amp, w: 0), forKey: "inputBVector")
  mapped.setValue(CIVector(x: 0, y: 0, z: 0, w: 1), forKey: "inputAVector")
  mapped.setValue(CIVector(x: 0.5 - 0.5 * amp, y: 0.5 - 0.5 * amp, z: 0.5 - 0.5 * amp, w: 0), forKey: "inputBiasVector")
  let blend = CIFilter(name: "CISoftLightBlendMode")!
  blend.setValue(mapped.outputImage!, forKey: kCIInputImageKey); blend.setValue(img, forKey: kCIInputBackgroundImageKey)
  img = blend.outputImage!.cropped(to: img.extent)
}

let ctx = CIContext()
try! ctx.writeJPEGRepresentation(of: img, to: outURL, colorSpace: srgb, options: [CIImageRepresentationOption(rawValue: kCGImageDestinationLossyCompressionQuality as String): 0.74])
print("wrote \(outURL.lastPathComponent) \(Int(img.extent.width))x\(Int(img.extent.height))")
