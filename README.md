# Opsis

A native macOS markdown viewer.

Opsis renders Markdown files with GitHub Flavored Markdown support, syntax-highlighted code blocks, and a clean GitHub-styled appearance -- all in a lightweight, native macOS app.

The name comes from the Greek *opsis* (opsis), meaning "sight" or "view."

## Features

- **GitHub Flavored Markdown** -- tables, task lists, strikethrough, autolinks, and more via [cmark-gfm](https://github.com/stackotter/swift-cmark-gfm)
- **Syntax highlighting** -- 20+ languages powered by highlight.js
- **Dark mode** -- follows system appearance automatically
- **Document-based** -- double-click `.md` files or use File > Open
- **Finder integration** -- registers as a viewer for `.md`, `.markdown`, and `.mdown` files. After first launch, Opsis appears in Finder's "Open With" menu
- **Smart typography** -- curly quotes, en-dashes, and em-dashes
- **GitHub-styled rendering** -- headings, blockquotes, code blocks, tables, and task lists
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
