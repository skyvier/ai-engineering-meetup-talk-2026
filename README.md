# Ohjelmistokehitys autonomisten agenttien aikakaudella

Slidev deck (Finnish) for the AI × Software Engineering meetup. Speaker: Joonas Laukka, Loihde.
Demo repository: <https://github.com/skyvier/verification-driven-ai-demo>

## Run, build, export

With Nix (flakes enabled):

```sh
nix develop   # Node.js 22; runs npm install on entry and whenever package.json/package-lock.json changes
```

The first run creates `flake.lock` and `package-lock.json`; commit both. Later runs use `npm ci`.

Without Nix: requires Node.js 20+ (22 recommended), then `npm install`.

```sh
npm install
npm run dev            # presenter at http://localhost:3030, presenter view at /presenter
npm run build          # static SPA into dist/
npx playwright install chromium   # once, needed for export
npm run export         # PDF of the slides  -> dist/ohjelmistokehitys-agenttien-aikakaudella.pdf
npm run export:notes   # PDF of speaker notes -> dist/puhujan-muistiinpanot.pdf
```

Other formats: `npx slidev export --format png` or `--format pptx` (slides as images).
For click steps as separate PDF pages, add `--with-clicks`.

## Files

| File | What |
|---|---|
| `slides.md` | All slides plus speaker notes (HTML comments at the end of each slide) |
| `style.css` | Visual system (Loihde palette, Arial, cards, callouts, code sizes) |
| `public/` | Loihde wordmark and emblem SVGs |
| `flake.nix` | Nix dev shell (Node.js 22, automatic npm install) |

Diagrams are inline SVG inside `slides.md`, with no Vue components, so they're easy to edit by hand.

## Structure and timing (~25 min + 2 min buffer + 3 min Q&A)

| # | Slide | Time |
|---|---|---|
| 1 | Kansi | 0:00–0:45 |
| 2 | Mistä tiedämme, että agentti on valmis? | –2:00 |
| 3 | Rajataan hyväksyttävien ohjelmien joukkoa | –4:00 |
| 4 | Yksi huone. Yllättävän monta sääntöä. | –5:30 |
| 5 | Sama tarkoitus, kolme ilmaisutapaa | –7:30 |
| 6 | Gherkin | –9:15 |
| 7 | Property testing | –11:30 |
| 8–9 | Tyypit (kaksi diaa) | –14:00 |
| 10 | Kääntyy. Ei vielä toimi. | –15:00 |
| 11 | Sopimus pysyy, toteutus saa muuttua | –17:00 |
| 12 | Toteutus läpäisi sovitut tarkistukset (PR #3) | –18:30 |
| 13 | Entä jos rajoja poistetaan? (PR #4–#7) | –20:30 |
| 14 | Testit vihreänä, sopimus eri (PR #5) | –23:00 |
| 15 | Mitä vihreä tulos ei kerro? | –24:00 |
| 16 | Mitä haluat päättää ennen delegointia? | –25:00 |
| B1–B2 | Varadiat: lähteet, vertailun rajoitukset | backup |

## Verification status of this first version

What was actually done:
- Repository refs checked on 2026-11-03: `main` = `98c0e1e` (same as the previously inspected baseline), PR #3 head = `9e1586f`. PR heads #1–#7 are listed in the sources backup slide.
- Every code excerpt was read from those commits. Excerpts that were shortened or re-wrapped are labelled on the slide.
- Added-test counts for PR #4/#6/#7 (+6/+5/+5) were counted from each branch's `test/booking.test.ts`. PR #5 added +3.
- Layout was checked with an **approximate** Chromium render: slides.md split like Slidev, rendered with `marked` plus `style.css` on a 980×552 canvas. All slides were checked for vertical overflow and horizontal code overflow. No overflow remains in that render.

What was **not** done:
- `slidev build` / `slidev export` were not run, because the npm registry wasn't reachable from the authoring environment. Run `npm install && npm run build` first and look through the deck in Slidev's own renderer. Things to watch: Shiki highlighting, the default theme's spacing, and fonts.
- The demo itself was not run. All PR results are the PRs' reported results, and the slides say so.

## Open points to check before the talk

- **PR #5 prompt change.** The edits to `IMPLEMENTATION_AGENT_PROMPT.md`, `AGENTS.md` and the README are in the implementation commit `c2244f3`, not the setup commit `18f02b0`. That suggests the agent received a prompt that still referred to a `ValidatedInterval` that no longer existed. Confirm who made the edit and when before saying this aloud.
- Slide 10 says the stub already passes "An empty interval is invalid", because it always answers `invalid`. This was derived from reading the code, not from a run. Optional: add a screenshot of your own recorded baseline run.
- Slidev version: `package.json` pins `@slidev/cli ^51`. If you prefer the latest major, update it and re-check the code-block styling.
