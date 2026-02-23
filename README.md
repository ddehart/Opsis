# Opsis

A native macOS markdown viewer designed for reading.

Opsis treats Markdown files as documents to be *read*, not code to be reviewed. The rendering is typographically refined -- Charter serif body text on a warm cream background, editorial-quality blockquotes, ornamental section breaks, and OpenType features like ligatures and old-style numerals. It's closer to a printed book than a GitHub README.

The name comes from the Greek *opsis* (opsis), meaning "sight" or "view."

## Design

Opsis follows an **editorial/literary** aesthetic. The goal is a reading experience where the interface disappears and the content feels effortless.

- **Charter serif** for body text -- warm, screen-optimized, bundled on macOS. San Francisco sans-serif for headings creates natural hierarchy.
- **Warm color palette** -- cream backgrounds, ink-like text, warm charcoal in dark mode. No pure white, no pure black.
- **Typographic details** -- hanging punctuation, ligatures, old-style numerals, decorative blockquote marks, gradient-fade section breaks with ornamental glyphs.
- **Reading-optimized layout** -- 720px content width for ~65-75 characters per line, generous line height (1.75), and spacing that serves the serif.

## Features

- **GitHub Flavored Markdown** -- tables, task lists, strikethrough, autolinks, and more via [cmark-gfm](https://github.com/stackotter/swift-cmark-gfm)
- **Syntax highlighting** -- 20+ languages powered by highlight.js
- **Dark mode** -- follows system appearance automatically with warm dark palette
- **Document-based** -- double-click `.md` files or use File > Open
- **Finder integration** -- registers as a viewer for `.md`, `.markdown`, and `.mdown` files
- **Smart typography** -- curly quotes, en-dashes, and em-dashes
- **External links** -- links open in your default browser, not in-app

## Requirements

- macOS 26 (Tahoe)
- Xcode 26.2+

## Building

The Xcode project is generated from `project.yml` using [xcodegen](https://github.com/yonaskolb/XcodeGen):

```bash
xcodegen generate
xcodebuild -scheme Opsis build
```

## Testing

Three test layers cover the rendering pipeline end-to-end:

```bash
# Unit tests — MarkdownRenderer, HTMLTemplate, MarkdownDocument
xcodebuild -scheme Opsis -only-testing OpsisTests test

# Integration tests — full pipeline verified via WKWebView + evaluateJavaScript
xcodebuild -scheme Opsis -only-testing OpsisIntegrationTests test

# UI tests — app launch, document opening, rendered content visibility
xcodebuild -scheme Opsis -only-testing OpsisUITests test

# All tests
xcodebuild -scheme Opsis test
```

## Tech Stack

- Swift 6.2 / SwiftUI with `DocumentGroup`
- [cmark-gfm](https://github.com/stackotter/swift-cmark-gfm) for GFM markdown parsing
- Native SwiftUI `WebView` (macOS 26) for rendering
- [highlight.js](https://highlightjs.org/) 11.9.0 for syntax highlighting
- [xcodegen](https://github.com/yonaskolb/XcodeGen) for project generation
