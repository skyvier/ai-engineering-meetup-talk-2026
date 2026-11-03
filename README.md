# Ohjelmistokehitys autonomisten agenttien aikakaudella

Slidev deck (Finnish) for the AI × Software Engineering meetup. Speaker: Joonas Laukka, Loihde.
The agent workflow section quotes the permission profile and prompt from the demo repository: <https://github.com/skyvier/verification-driven-ai-demo>

## Run, build, export

With Nix (flakes enabled):

```sh
nix develop   # Node.js 22; runs npm install on entry and whenever package.json/package-lock.json changes
```

The first run creates `flake.lock`; commit it. `package-lock.json` is committed, so later runs use `npm ci`.

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

## Structure and timing (~30 min, then Q&A)

The talk targets about 30 minutes; a little shorter or longer is fine. Each slide's speaker notes start with its planned time range.

| # | Slide | Time |
|---|---|---|
| 1 | Kansi | 0:00–0:45 |
| 2 | Agentti työskentelee silmukassa | –1:30 |
| 3 | Mistä tiedämme, että agentti on valmis? | –3:15 |
| 4 | Kuinka tiukka "valmis"? | –4:45 |
| 5 | Deterministisiä tarkistuksia on monenlaisia | –6:00 |
| 6–7 | Tyypit: todiste, sopimus koodin sisällä | –8:30 |
| 8–10 | Ominaisuustestit: esimerkki vai laki, vastaesimerkin etsintä, koodi | –12:30 |
| 11–12 | Hyväksymistestit: tiketti, Gherkin | –14:15 |
| 13 | Vakaa rajapinta ensin | –15:30 |
| 14 | Rajataan hyväksyttävien ohjelmien joukkoa | –16:30 |
| 15–18 | Mistä tarkistukset tulevat? (yleiskuva, kriteerit, ominaisuudet, tyypit) | –21:30 |
| 19 | Määrittele järjestelmä, älä toteutusta | –21:45 |
| 20–22 | Eristä agentti tarkistuksesta: työtila, ohje, riippumaton tarkistus | –26:00 |
| 23 | Missä ihmisen työ on? (piirros) | –27:00 |
| 24 | Päästä agentti irti | –27:15 |
| 25 | Agentin PR: mergeäisitkö lukematta diffiä? | –28:15 |
| 26 | Mitä vihreä tulos ei kerro? | –29:15 |
| 27 | Kuinka paljon huomiota muutos ansaitsee? | –30:30 |
| 28 | Kolme askelta (lopetus) | –31:30 |

All code examples use an invented web-shop discount example and are labelled on the slides (simplified example or illustration). The agent workflow slides show the demo repository's structure with discount-example file names, and its permission profile and prompt (reformatted, shortened and translated).

## Status

- `slidev build` and `slidev export` run cleanly. Every slide was checked in Slidev's own renderer for overflow.
- `package.json` pins `fuse.js` to 7.1.0 with an npm override; see `CLAUDE.md` for why.
- The demo itself is not run during the talk.

## Open points to check before the talk

- Slidev version: `package.json` pins `@slidev/cli ^51`. If you prefer the latest major, update it and re-check the code-block styling and the Goto dialog.
