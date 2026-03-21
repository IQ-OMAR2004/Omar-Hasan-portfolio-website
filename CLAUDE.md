# CLAUDE.md — Omar Hasan Portfolio Website

## Project Overview
A single-page personal portfolio website for **Omar Alaa Hasan**, an Electrical Engineering student at KFUPM. Built as a single HTML file (`index.html`) with no build system or framework — everything is self-contained.

## Tech Stack
- **HTML5** — single file, no separate JS/CSS files
- **Tailwind CSS** — loaded via CDN (`https://cdn.tailwindcss.com`), configured inline via `tailwind.config`
- **Vanilla JavaScript** — embedded in `<script>` tags at the bottom of the file
- **Font Awesome 6.4.0** — for icons, loaded via CDN
- **Google Fonts** — Inter + Outfit, loaded via CDN
- **Spline Viewer** — 3D interactive embed (`@splinetool/viewer@1.12.67`) in the About section
- **No npm, no bundler, no framework** — open the HTML file directly in a browser

## File & Asset Structure
```
Omar Hasan website /
├── index.html              ← The entire website (this file)
├── Omar_Hasan_CV.tex       ← CV file (linked for download in navbar)
├── My_photo.jpg            ← Profile photo (hero section)
├── thomas-kelley-xVptEZzgVfo-unsplash.jpg    ← Project 1 image
├── christian-dubovan-gxsRL8B_ZqE-unsplash.jpg ← Project 2 image
├── pexels-aizat-ramlan-1291546-9679179.jpg    ← Project 3 image
├── pexels-sejio402-6636476.jpg               ← Project 4 image
├── laurens-van-der-drift-iv2-3AeAO-A-unsplash.jpg ← Project 5 image
```
> All asset paths use `../Omar%20Hasan%20website%20/` prefix (URL-encoded folder name with trailing space).

## Page Sections (in order)
1. **`#hero`** — Name, tagline, CTA buttons, profile photo, social links
2. **`#about`** — Bio text + Spline 3D interactive model
3. **`#experience`** — Two-entry timeline (iHub + EE Club)
4. **`#projects`** — 5-card grid (Holographic Fan, Factory Circuit, Air Pollution ML, Embedded Systems, Sleep Health)
5. **`#skills`** — 4 categories: Hardware/Embedded, Programming, Engineering Tools, Languages
6. **Education & Leadership** — KFUPM degree + 4 leadership roles (no anchor ID)
7. **`#contact`** — Contact form (opens mailto on submit)
8. **Footer** — Email, phone, LinkedIn, GitHub links

## Design System

### Color Palette (Tailwind custom config)
| Token | Value | Usage |
|---|---|---|
| `surface` | `#0a0a0a` | Page background |
| `surfaceLight` | `#171717` | Cards, inputs |
| `primary` | `#0ea5e9` | Sky blue accent, borders, icons |
| `primaryGlow` | `rgba(14,165,233,0.4)` | Glow effects |
| `textMuted` | `#a3a3a3` | Secondary text |

### Key CSS Classes (custom, defined in `<style>`)
- `.glass` — glassmorphism navbar/overlays (backdrop-filter blur)
- `.glass-card` — project/experience cards with hover lift + glow
- `.text-gradient` — white-to-primary gradient text (used on name)
- `.reveal` — scroll animation target (opacity:0 + translateY, activated by JS)
- `.orb` — ambient background blobs with drift animation
- `.timeline-dot` — glowing dot on experience timeline

### Typography
- **Display/headings**: `Outfit` font (`font-display`)
- **Body**: `Inter` font (`font-sans`)

## JavaScript Modules (all in one `<script>` block)

### `initScrollReveal()`
Uses `IntersectionObserver` (threshold: 0.15) to add `.active` class to `.reveal` elements when they enter the viewport. This triggers the fade-up entrance animation.

### `handleNavbarScroll()`
Listens to `window.scroll` — adds shadow and border color changes to `#navbar` when `scrollY > 50`.

### `initMotionRespect()`
Checks `prefers-reduced-motion` media query. If true, hides `#spline-container` entirely.

### `initContactForm()`
- Intercepts form submit (`#contactForm`)
- Shows a success toast overlay with animation
- After 1.5s delay, opens `mailto:omar.alaa2004@outlook.sa` with pre-filled subject + body
- Resets form after another 1s

## Common Tasks for Claude Code

### Adding a New Project Card
Copy the pattern from an existing project in `#projects`. Each card needs:
- A `<div class="glass-card rounded-2xl overflow-hidden flex flex-col h-full reveal group">`
- An image `<div class="h-48 ...">` with `<img>` inside
- A tag row using `<span class="px-2 py-1 rounded bg-white/5">`
- `<h3>` title and `<p>` description
- Add `delay-100` or `delay-200` to the card's `reveal` class to stagger animation

### Adding a New Experience Entry
Copy an existing `.relative.w-full.mb-12` block in `#experience`. Update:
- Date span and location in the left column (desktop)
- The `.glass-card` content: role title, org, and `<ul>` bullet points
- Add `delay-100` to stagger if it's the second item

### Changing the Color Accent
Change `primary: '#0ea5e9'` in `tailwind.config` and update the raw hex `#0ea5e9` values in `<style>` (used in `.timeline-dot` shadow and `.glass-card:hover` shadow).

### Adding a New Skills Category
Copy a `.reveal` block inside `#skills`'s grid. For progress-bar skills use the `.group > div.h-1.5` pattern. For tag-style skills use the `<span class="px-4 py-2 rounded-lg bg-surface border ...">` pattern.

### Updating Contact Info
- Email: `omar.alaa2004@outlook.sa` — appears in hero, footer, and JS mailto handler
- Phone: `+966569553175` — in footer and JSON-LD
- LinkedIn: `https://www.linkedin.com/in/omar-hasan-952894246`
- GitHub: `https://github.com/IQ-OMAR2004`

## Important Notes
- **No build step** — edit `index.html` directly, refresh browser to see changes
- **Tailwind CDN** — only core utility classes are available (no custom purging/JIT)
- **Image paths** — use `../Omar%20Hasan%20website%20/filename.jpg` pattern (note the URL-encoded space)
- **Print styles** — `@media print` block hides nav, orbs, and resets colors to black/white for CV printing
- **Accessibility** — focus-visible styles are set on `a` and `button`; aria-labels on icon-only links
- **JSON-LD** — structured data for the person is in a `<script type="application/ld+json">` in `<head>`
