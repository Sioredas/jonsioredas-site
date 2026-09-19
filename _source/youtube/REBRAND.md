# YouTube rebrand — The Wrestling Institute → Jon Sioredas

Channel: **@JonSioredas** · 3.2K subscribers · 42 videos · ~470K lifetime views on the
top 20 alone. Name and handle are already right. Everything below is what still says TWI,
plus the assets and copy to replace it with.

---

## 0. Before you start: the channel isn't on the account you're signed into

Chrome is signed in as **sioredas@me.com**. That Google account has no channel of its own —
it only has a brand account called *MartinsGranbySchool*. **@JonSioredas is owned by a
different Google account**, probably the original one the Wrestling Institute was set up on.

Nothing below can be applied until you sign in as the owner. Find it by opening
youtube.com, switching accounts, and looking for the one where @JonSioredas shows
*Customize channel* instead of *Subscribe*. If none of your accounts work, the channel was
created under an email you'll need to recover.

---

## 1. Every place TWI still appears

| # | Where | What it says now | Fix |
|---|-------|------------------|-----|
| 1 | Channel description (About) | `http://TheWrestlingInstitute.com` — that's the entire description | Replace with §3 |
| 2 | Channel Links | `thewrestlinginstitute.com`, shown under the banner | Replace with §4 |
| 3 | **All 42 video descriptions** | Every one opens `For more, visit: http://thewrestlinginstitute.com/` | §6 — the big job |
| 4 | Channel banner | none at all right now | Upload `youtube-banner.png` |
| 5 | Profile picture | old grey-background headshot, off-brand | Upload `youtube-avatar.png` |
| 6 | Channel keywords | unknown — check Settings → Channel → Basic info | Replace with §5 |
| 7 | Business email | check About → it may be a TWI address | §5 |
| 8 | End screens & cards | may link to TWI | Repoint to jonsioredas.com |
| 9 | Video watermark | probably empty or a TWI mark | Upload `youtube-watermark.png` |
| 10 | Burned-in intros/outros | TWI graphics *inside* the footage | Can't be fixed without re-editing and re-uploading — and re-uploading throws away 47K views. **Leave them.** |

**Good news:** thewrestlinginstitute.com already redirects to jonsioredas.com, so none of
these links are broken. This is a branding cleanup, not a rescue — do it at your own pace,
in the order above.

---

## 2. Assets — built, ready to upload

All in `_source/youtube/out/`. Source HTML sits next to them; `./render.sh` rebuilds.

| File | Size | Where it goes |
|------|------|---------------|
| `youtube-banner.png` | 2560×1440, 1.0 MB | Customize channel → Branding → Banner image |
| `youtube-avatar.png` | 800×800, 716 KB | Branding → Picture **(recommended)** |
| `logo-monogram.png` | 800×800, 260 KB | Alternative picture; also your mark for graphics |
| `youtube-watermark.png` | 150×150, transparent | Branding → Video watermark, "Entire video" |
| `thumbnails/*.png` | 1280×720 | Examples from the reusable template |

**Banner** — the design lives entirely inside YouTube's 1546×423 safe area, so the headline,
credentials and URL survive on a phone. The action shot is cropped so your face clears the
safe-area edge by ~195px; on a wide monitor the full pointing gesture comes into frame.

**Profile picture** — your Cal Poly headshot, cropped so your head fills ~58% of the circle
(it has to read at 48px in a comment thread) with a gold ring. The photo was already shot on
Cal Poly green, so the background *is* the brand background.

**Use the face, not the monogram.** This is a personal-brand channel — people subscribe to
you. The JS mark's job is the watermark and the thumbnail corner, where a face would be
unreadable.

### Thumbnails

One template makes them all, so the channel looks like a channel instead of 42 strangers:

```bash
cd "/Users/jsioreda/Desktop/Claude Code/jonsioredas-site/_source/youtube" && ./make-thumb.sh cornell-tilt "TOP WORK" "THE CORNELL" "TILT" ../../images/camp-huddle.jpg "50% 45%"
```

Arguments: output name, series chip, line 1, line 2, image path, focal point. Point it at a
still from the video. Keep to 2–4 words a line — on a phone the whole thumbnail is the size
of a business card.

---

## 3. Channel description

Paste into Customize channel → Basic info → Description. Only the first line shows before
"...more", so it carries the weight.

```
Division I wrestling technique, drills and coaching from Jon Sioredas — head coach at Cal Poly and President of the National Wrestling Coaches Association.

This is what we actually teach in our room: hand fighting, takedown setups and finishes, riding and tilts, escapes and bottom work, reaction drills, and the culture work behind a program ranked in the national Top 25 six straight seasons.

Made for wrestlers who want to get better between practices, and for coaches building a room of their own.

Two-time Pac-12 Coach of the Year · NCAA All-American · 20 seasons coaching college wrestling · 10 All-Americans and 70 NCAA qualifiers.

Camps, clinics and speaking: jonsioredas.com
Mustang Wrestling Camp: mustangwrestlingcamp.com
Cal Poly Wrestling: gopoly.com/sports/wrestling
```

---

## 4. Links

Customize channel → Basic info → Links. The first one is displayed on the channel banner.

| Title | URL |
|-------|-----|
| Camps, Clinics & Speaking | https://jonsioredas.com |
| Mustang Wrestling Camp | https://mustangwrestlingcamp.com |
| Cal Poly Wrestling | https://gopoly.com/sports/wrestling |
| Mustang Wrestling Foundation | https://mustangwrestlingfoundation.org |
| Central Coast RTC | https://centralcoastrtc.org |
| Instagram | https://instagram.com/jon_sioredas |
| X | https://x.com/JonSioredas |

Delete the existing `thewrestlinginstitute.com` link.

---

## 5. Keywords and contact

**Channel keywords** — Settings → Channel → Basic info (500 characters total):

```
wrestling, wrestling technique, college wrestling, folkstyle wrestling, Jon Sioredas, Cal Poly wrestling, hand fighting, takedowns, leg attacks, riding and tilts, escapes, bottom wrestling, wrestling drills, wrestling coaching, NCAA wrestling, high school wrestling, youth wrestling, wrestling practice, Division I wrestling, wrestling camp
```

**Country:** United States. **Business email:** `jsioreda@calpoly.edu` — note the spelling,
there is no "s" before the @. YouTube puts this behind a CAPTCHA, so spam risk is low. If
you'd rather keep your Cal Poly address off the channel entirely, leave the field empty and
let the description send people to the contact form on jonsioredas.com.

---

## 6. Video descriptions — the actual TWI cleanup

All 42 open with `For more, visit: http://thewrestlinginstitute.com/`. There is no bulk
find-and-replace in YouTube Studio, so this is 42 manual edits. Studio → Content → hover a
video → pencil → edit description → Save. About 15 seconds each once you get going.

**Do the top 10 by views first** — that's where nearly all the traffic is:

Hand Fighting 101 (47K) · Inside Bar and Cross Wrist Defense (46K) · Handfight Techniques
(36K) · Getting to the legs with quick ties (34K) · Cornell Tilt (30K) · Pressure Ride (29K)
· Cheap Tilt (25K) · Front Head Locks (15K) · Back Door Finish (14K) · Low Single Leg
Defense (14K)

**Template** — keep the existing first paragraph of each video, swap the TWI line for this:

```
Coached by Jon Sioredas — head coach, Cal Poly wrestling, and President of the National Wrestling Coaches Association.

━━━━━━━━━━━━━━━━━━━━
MORE FROM COACH SIOREDAS
Camps, clinics + speaking → https://jonsioredas.com
Mustang Wrestling Camp → https://mustangwrestlingcamp.com
Cal Poly Wrestling → https://gopoly.com/sports/wrestling
Instagram → https://instagram.com/jon_sioredas

Subscribe → https://youtube.com/@JonSioredas?sub_confirmation=1
━━━━━━━━━━━━━━━━━━━━

#wrestling #wrestlingtechnique #collegewrestling
```

`?sub_confirmation=1` pops the subscribe dialog open instead of just loading the channel.

**Don't retitle the videos.** Titles like "Cornell Tilt - Wrestling Top Work Technique" are
why those videos still rank after 13 years. Renaming them resets that.

---

## 7. Playlists — all 42 videos, sorted

You have none. Seven playlists turn a dumped archive into a curriculum, and they surface in
search on their own. Studio → Content → Playlists → New.

**1. Hand Fighting & Ties** (4) — the strongest set you have, 120K views between them
Hand Fighting 101 · Hand Fighting 201 · Handfight Techniques · Getting to the legs with quick ties

**2. Leg Attacks & Finishes** (9)
Near Arm Far Ankle · Near Arm Far Ankle Options · Crack Hold · Cut Back · Back Trip ·
Simple Funk Defense · Quick Finish · Back Door Finish · Tripod Series

**3. Top Work: Rides, Tilts & Turns** (12) — your deepest series
Cornell Tilt · Cheap Tilt · Melchiore Tilt · Pressure Ride · Reinforced Bar · Side Clinch
Crab to Boot · Back Trip Cradle · Cross Wrist Tight Waist Roll Thru · Basic Leg Position ·
How to get better on top · ReTackle Top Return · Proper Lift Return

**4. Bottom Work: Escapes & Reversals** (4)
Inside Bar and Cross Wrist Defense · Hip Separation and Seal · Elbow Pinch Sit Out · Feet First Standup

**5. Defense & Front Headlock** (5)
Low Single Leg Defense · Legs Defense · Backdoor Defense · Front Head Locks · Front Head Lock Sneak Attack

**6. Reaction Drills** (7)
Force Him to Shoot and Fly · Snap and Fly · Downblock Fly · Down Block Fly (Defense) ·
180 Drill · Offensive ReShot · Defensive ReShot

**7. Live & Situational** (1)
Pre-match Spar

Give each a one-line description ending in `jonsioredas.com`. Then Customize channel →
Layout → add each playlist as a shelf, Hand Fighting at the top.

---

## 8. The rest of the polish

**Channel trailer** (shown to non-subscribers) — record a new one: 45–60 seconds, you on
the mat, "here's who I am, here's what's on this channel, here's what you'll get better at."
Nothing you have now works as a trailer. Until it exists, set **Hand Fighting 101** — it's
your best-performing video and a fair sample of the channel.

**Featured video for returning subscribers** — use your most recent upload, or Hand
Fighting 201.

**Layout** (Customize channel → Layout) — Featured sections in this order: trailer,
Hand Fighting, Top Work, Leg Attacks, Bottom Work, Defense, Reaction Drills, Videos.

**Watermark** — Branding → Video watermark → `youtube-watermark.png`, display time
"Entire video". Turns every one of your 42 videos into a subscribe button.

**End screens** — add to the top 10 by views: one "subscribe" element and one "best for
viewer" element, last 15 seconds.

**Custom thumbnails** — most of the 42 are auto-generated frames. Rebuilding the top 10
with the template in §2 is the single highest-return hour on this list.

**Shorts** — every technique video has one 20-second money detail in it. Clipping those
into Shorts is the cheapest way to grow from 3.2K, and the footage already exists.

**Comments** — check Settings → Community for 13 years of unmoderated comments.

---

*Assets and sources: `jonsioredas-site/_source/youtube/`. Rebuild with `./render.sh`.*
