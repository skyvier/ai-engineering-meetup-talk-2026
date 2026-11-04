# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A Slidev slide deck in Finnish for a ~30-minute AI × Software Engineering meetup talk ("Ohjelmistokehitys autonomisten agenttien aikakaudella", Joonas Laukka, Loihde). It argues for defining a system with types, property tests and acceptance tests before delegating the implementation to an agent, then shows how to run the agent against that contract. There is no application code and there are no tests. The deck itself is the product.

## Commands

```sh
nix develop            # optional: Node.js 22 shell, auto-runs npm install / npm ci
npm install
npm run dev            # http://localhost:3030, presenter view at /presenter
npm run present        # open presenter view (starts the dev server if needed)
npm run slides         # open the audience view (starts the dev server if needed)
npm run build          # static SPA -> dist/
npx playwright install chromium   # once, before exporting
npm run export         # slides PDF -> dist/ohjelmistokehitys-agenttien-aikakaudella.pdf
npm run export:notes   # speaker-notes PDF -> dist/puhujan-muistiinpanot.pdf
```

Add `--with-clicks` to `slidev export` to get click steps as separate pages. Commit `flake.lock` when it first appears; `package-lock.json` is already committed.

`package.json` pins `fuse.js` to 7.1.0 with an npm override. Newer fuse.js returns every item for an empty search, which makes Slidev 51's hidden Goto dialog list all slide titles over the deck. Remove the override only after upgrading Slidev and checking that the dialog stays hidden.

## Structure

- `slides.md` holds every slide. Slides are separated by `---`, and the first block is the global Slidev headmatter (16:9, `canvasWidth: 980`, Arial, light scheme). Each slide ends with an HTML comment containing its speaker notes in Finnish, opened with a `[m:ss–m:ss]` timing marker. The README has the slide-by-slide timing table. Keep the two in sync when slides are added, removed or retimed.
- Diagrams are inline SVG directly in `slides.md`. Don't introduce Vue components; the inline SVG is meant to stay hand-editable. Set SVG text size with `style="font-size:13px"`, never a `font-size="13"` attribute. Slidev's UnoCSS attributify mode reads that attribute as a utility class and renders the text at 3.25rem.
- `style.css` is loaded automatically by Slidev after the default theme. It defines the Loihde palette as `--l-*` CSS variables and the utility classes the slides rely on: layout grids (`cols`, `cols-3`, `cols-4`, `cols-wide-left`), `card` (`accent`/`teal`/`soft`), `callout` (`teal`), `kicker`, `small`/`tiny`, `src` (source citations), `code-sm`, `label-illustrative`, `reported`, `ok`/`bad`, `terminal`. Use these classes instead of new inline styles. The file also overrides some default-theme rules (h1 + p fade, list line-height). Check those overrides before you change typography.
- The slide `class: brand` and the `layout: cover` slide use the dark brand look with the white logo from `public/`. `class: brand statement` with `layout: center` is the big one-line statement style; `.h1-sub` is the subtitle line under a section title.
- When slides are reordered, the running dev server can serve stale per-slide `<style>` blocks. Restart it before judging a layout.

## Content accuracy rules

- All code examples use an invented web-shop discount example (`Money`, `Percent`, `applyDiscount`, campaign codes). Label them on the slide as a simplified example or illustration (`src`, `label-illustrative`). Don't present invented output or results as real.
- The agent workflow slides quote the demo repo <https://github.com/skyvier/verification-driven-ai-demo>: its Codex permission profile and `IMPLEMENTATION_AGENT_PROMPT.md`. Keep those faithful to the repo; reformatting, shortening and translating are fine if the slide says so. The repo's own domain (meeting-room booking) is deliberately kept out of the deck.
- The README lists open points to check before the talk. After layout changes, check every slide for overflow in Slidev itself, not just one screenshot.
