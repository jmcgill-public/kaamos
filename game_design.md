# KAAMOS — Game Design Plan
## Station Nine: Three-Stage Loop

*Design authority: world_bible.md. This document describes implementation intent.*
*Register: software developers / gamers. The apparatus is not foregrounded.*

---

## The Throughline

The Silence operates in a vocabulary of six. The worldborn minimum is seven (Miller's Law). The gap between six and seven is the game. The player crosses that gap in three stages without being told they are crossing anything.

| Stage | Name | Register | What the player thinks they're doing | What they're actually doing |
|-------|------|----------|--------------------------------------|-----------------------------|
| 1 | Simon + Alphabet | Reko | Playing Simon. Watching shapes accumulate. | Learning to read. |
| 2 | Mastermind | Turo | Deducing a four-station route. | Confirming what they already know. |
| 3 | Hunt | Keijo | Navigating a hex map. Avoiding a hazard. | Discovering that every death wrecks a world. |

The game does not change. The player gets closer.

---

## Stage 1 — Simon + Alphabet

### Attract mode

Williams barker screen energy. The machine is already running when the player arrives. The Hiljaisuus pulse (6.67s / 0.15Hz) is active. The interface does not ask you to play. It assumes you will.

No instructions. No tutorial overlay. The four station buttons are present and doing something. The player touches one.

### Simon mechanic

Classic Simon: the machine plays a sequence, the player mirrors it. On correct mirror, the sequence extends by one.

**Difficulty envelope:**

The only wall is Miller's Law (7 ± 2 chunks in working memory). Everything else is on the player's side:

- Sequences start at length 2.
- Playback speed begins slow — approximately 0.6× the tempo of a standard Simon game.
- Speed increases gradually but never aggressively. The goal is to reach sequence lengths of 5–9, not to stress the reflexes.
- Buttons light up and *decay* — they hold their illuminated state for a full beat before fading. The sequence reads like text, not a test. The machine wants you to succeed.

**Station set:**

5–8 stations per session, drawn from a generative pool of Finnish-register names (three syllables, Finnish mouth-feel). The canonical eight station names are used when the book has earned them. Until then the generative pool is live and the names are real — they are just not yet mapped to canon geography.

The player does not know which set they will see until the session begins. The set is revealed incrementally as glyphs accumulate.

### Glyph generation

Each solved Simon round produces one glyph.

The glyph is the written form of the station name at the head of the sequence — the first station played in that round. The sequence is the input; the glyph is the transform.

**The transform must produce something legible as alphabet.** The literal Simon trace (up-right-down-left in some order) is a skeleton. The glyph is the flesh. Design intent: radial, dense at center, extending outward. Something a person could plausibly spend years studying. Twenty glyphs side by side and the brain starts guessing at grammar.

The heptapod glyphs from *Arrival* (Villeneuve, 2016) are the aesthetic reference — generated from a different underlying logic than the surface trace, legible as writing system, carrying the feeling of a language with grammar.

The generative rule for the KaamOS glyph is: **[to be defined in glyph_spec.md — this is the open design problem].**

**Glyph display:**

Glyphs accumulate in a panel visible throughout the session. They do not disappear between rounds. By the time the player reaches Mastermind, they have seen the written forms of the stations multiple times. They do not know they have been learning to read.

The glyph panel is the Gold-Bug thread. Patient players will notice before they are told.

### Stage transition

After sufficient glyph accumulation (target: 6–8 solved rounds, tunable), the game transitions to Mastermind. The transition is not announced. The interface shifts.

---

## Stage 2 — Mastermind (Turo)

### Character register

Turo is Dupin. The Purloined Letter is a Mastermind puzzle. The pattern is visible to those who look correctly. Turo needs no lines in a scene — his presence is the observation.

The player does not know they have become Turo. They are simply deducing a route.

### Mechanic

Classic Mastermind: a hidden four-station code, up to 10 probe attempts, feedback as exact (●) and present (○) indicators.

**The stations in the Mastermind round are drawn from the same set the player saw in Simon.** They have seen the glyph forms. They know the names. The Silence has encoded a route using the alphabet the player has been accumulating.

The WoF (Wheel of Fortune) board reveals exact-match positions as they are confirmed. The discard pile shows confirmed-absent stations with strikethrough. The solve modal is a one-shot full-code attempt — it costs nothing to open but the silence is watching.

**ACCESS GRANTED** must land with weight, not release. The route is confirmed. The cost of confirming it is about to become visible.

### Hiljaisuus pulse

6.67 seconds / 0.15Hz throughout. Hardcoded. This is not a tunable parameter.

### Loop structure

Simon → Mastermind is one cycle. The cycle repeats with increasing difficulty (longer Simon sequences, tighter Mastermind probe budgets) until the player has accumulated enough language to enter the Hunt.

The number of cycles before Hunt unlock: **[tunable — target 3–5 cycles].**

---

## Stage 3 — Hunt (Keijo)

### Character register

Keijo is Eureka Poe. Every death wrecks a world. He knew. He wrote it down. He was not believed.

The player does not know they are Keijo. They are navigating a hex map.

### The map

Radius-2 hex grid. 8 named stations as nodes. BFS-constrained edges. The topology is the same topology the Simon glyphs were fingerprinting — 109,600 possible sequences, 67,753 distinct base glyphs, bell curve peaking at 16 edges. Ara knows the count.

The Hunt map is larger than the Simon station set. The player is inside the glyph space now, not looking at it from outside.

### Move-or-shoot

Hunt the Wumpus mechanic. Each turn: move to an adjacent hex, or fire a probe through one or more edges.

Sensory feedback from adjacent hexes warns of hazards before contact. The player infers location from indirect signal.

### Death — the move clock

There is no combat. No health. No creature attack.

Death is a strict move clock. The player has a fixed number of moves to locate and couple the hehju. Clock expires: route lost. The pressure is temporal and structural, not adversarial. This is consistent with the Silence — it does not attack. It makes you aware that it could. The clock is the awareness.

**Failure state:** The coupling was not made in time. The log entry is quiet and means what it says:

> ROUTE UNCONFIRMED.
> YOU COULD NOT COUPLE THE HEHJU.

No drama. No mockery. The station knows how you traveled. Toned appropriately.

### The hehju

**hehju = Strait of Hormuz.** A chokepoint. Contested passage. Control the strait, control the flow.

The hehju is a route coupling — a structural hazard in the brane transit network where two folds almost touch and passage is never guaranteed. This is the wumpus. It does not move like a creature. It is a fact in the topology. The player finds it by inference or finds it by dying.

The hehju does not attack. It makes you aware that it could. The fear is anticipatory. *Painajainen* — the nightmare is the moment before you know it's a nightmare.

**Sensing the hehju:** Adjacent hexes carry a signal — the coupling resonance. The player can feel the chokepoint before they see it. The signal has a specific aesthetic register (violet, Hiljaisuus family) distinct from the normal nav display (green = go, violet = watch).

**Shooting:** The player can fire a probe through one or more hex edges without moving. A correct shot resolves the coupling. An incorrect shot costs a probe from the Mastermind budget (the probe economies are connected — **[this connection is a design decision to confirm]**).

### BFS pathfinding — the Silence

The Silence walks routes. It does not teleport. BFS-constrained movement through the hex grid. Violet = watch (Silence is adjacent). Green = go (route is clear). Cursor goes dead during contact phase.

The Silence does not attack. Its movement is inevitable if the player does not manage the route. Managing the route is the game.

### The Sylvester event

Somewhere in the nav chart, a world that was present is gone.

The player did not see it happen. The game did not announce it. There is no moment of horror — only a gap in the chart where a name used to be. `ROUTE UNCONFIRMED`. The log entry is quiet.

The player caused it. They will not be told this directly. They will know when they look at the chart and count.

This is the Keijo register completing: *every death wrecks a world. He knew. He wrote it down.*

---

## Cross-Stage Architecture

### The alphabet is load-bearing

The Simon glyphs are not decorative. They are the written system the Hunt map is labeled in. A player who paid attention in Stage 1 can read the Hunt map on arrival. A player who didn't is navigating by sound.

Both are valid paths. The game does not require literacy. It rewards it.

### Miller's Law as structural law

| Number | Meaning |
|--------|---------|
| 6 | The Silence's vocabulary. Below worldborn minimum. |
| 7 | The worldborn ceiling. The fear of the void is a cognitive limit wearing a cosmological mask. |
| 8 | The machine's number. Parity. Error correction. The algorithm contained. |
| 9 | Hiljaisuus. The unmapped station. The fold that costs a world. |

The game is designed so the player is always operating at 7 — the minimum viable cognition for the task. The Silence is always at 6. The gap is always one.

### Currency

Simon coin accumulates from Simon performance (proportional to sequence length reached). Mastermind coin accumulates from probe efficiency (probes remaining on solve). The two currencies are distinct and do not convert.

Both currencies carry into the Market (deferred — when the novel earns it). Max both = qualitatively different tier.

---

## Sound Design

**For the Zero Dollar Studio team.**

The game requires a sound vocabulary. Station tones for Simon are the first sounds the player hears from this world — they should be drawn from F# Phrygian (the key of the record) and built from the Tyhjyydenkaiku FM patch family. The Web Audio API supports in-browser FM synthesis; no samples are required for the core vocabulary, though the koivuhuilu and kuolinvihellys warrant real recordings when available.

The station tones, the Hiljaisuus ambient drone, the hehju coupling resonance, and the failure/success states are all one instrument. The player hears the key signature before the music exists. When the record plays, they already know the tones.

Sound design spec to be detailed in `sound_design.md` (to be created).

---

## Open Design Problems

1. **Glyph generative rule** — what is the transform from Simon sequence to KaamOS glyph? The aesthetic target is defined (heptapod register, radially dense, grammatically legible). The algorithm is not yet specified. See `glyph_spec.md` (to be created).

2. **Stage 1→2 transition trigger** — number of solved Simon rounds before Mastermind unlocks. Target 6–8. Needs playtesting against Miller's Law envelope.

3. **Stage 2→3 transition trigger** — number of Simon→Mastermind cycles before Hunt unlocks. Target 3–5.

4. **Probe economy connection** — does the Hunt inherit the Mastermind probe budget, or does it run its own? The thematic case for inheritance: the route you confirmed in Mastermind is the route you're now flying. The probe you spend in the Hunt is the same probe you spent learning the code.

5. **Sylvester event timing** — when in the Hunt loop does the world go dark? Earliest possible: after the first hehju encounter. The player should have had time to feel competent before the chart shows the gap.

6. **hehju count** — how many hehju couplings per Hunt map? One is classical (single wumpus). More than one changes the inference problem significantly.

---

*Last updated: May 2026.*
*Design authority: world_bible.md.*
*Push to GitHub after each session.*
