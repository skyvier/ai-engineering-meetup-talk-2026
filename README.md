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
npm run dev            # http://localhost:3030, presenter view at /presenter
npm run present        # open presenter view (starts the dev server if needed)
npm run slides         # open the audience view (starts the dev server if needed)
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

The talk targets about 30 minutes; a little shorter or longer is fine. Each slide's speaker notes start with its planned time range, based on a timed rehearsal (29 min before the last cuts).

| # | Slide | Time |
|---|---|---|
| 1 | Kansi | 0:00–0:30 |
| 2 | Agentti työskentelee silmukassa | –1:15 |
| 3 | Mistä tiedämme, että agentti on valmis? | –3:25 |
| 4 | Kuinka tiukka "valmis"? | –4:25 |
| 5 | Deterministisiä tarkistuksia on monenlaisia | –5:25 |
| 6 | Rajataan hyväksyttävien ohjelmien joukkoa (esikatselu) | –6:10 |
| 7 | Esimerkki: alennus verkkokaupan kassalla (tarkoituksella yksinkertainen) | –7:10 |
| 8–9 | Tyypit: todiste, sopimus koodin sisällä | –9:10 |
| 10–11 | Ominaisuustestit: esimerkki vai laki, laki koodina ja vastaesimerkki | –11:40 |
| 12–13 | Hyväksymistestit: tiketti, Gherkin | –13:15 |
| 14 | Mikä jää leikkauksen ulkopuolelle? (paluu joukkokuvaan) | –14:15 |
| 15 | Vakaa rajapinta ensin | –15:00 |
| 16–19 | Mistä tarkistukset tulevat? (yleiskuva, kriteerit, ominaisuudet, tyypit) | –19:00 |
| 20 | Määrittele järjestelmä, älä toteutusta | –19:15 |
| 21–22 | Eristä agentti tarkistuksesta: työtila, ohje ja uudelleenajo puhtaassa kopiossa | –21:55 |
| 23 | Missä ihmisen työ on? (piirros) | –22:40 |
| 24 | Päästä agentti irti | –22:50 |
| 25 | Agentin PR: mergeäisitkö lukematta diffiä? | –23:35 |
| 26 | Mitä vihreä tulos ei kerro? | –24:45 |
| 27 | Kuinka paljon huomiota muutos ansaitsee? | –26:45 |
| 28 | Kolme askelta (lopetus) | –27:15 |

All code examples use an invented web-shop discount example and are labelled on the slides (simplified example or illustration). The agent workflow slides show the demo repository's structure with discount-example file names, and its permission profile and prompt (reformatted, shortened and translated).

## Status

- `slidev build` and `slidev export` run cleanly. Every slide was checked in Slidev's own renderer for overflow.
- `package.json` pins `fuse.js` to 7.1.0 with an npm override; see `CLAUDE.md` for why.
- The demo itself is not run during the talk.

## Open points to check before the talk

- Slidev version: `package.json` pins `@slidev/cli ^51`. If you prefer the latest major, update it and re-check the code-block styling and the Goto dialog.
