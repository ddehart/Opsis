# Opsis Roadmap

## Next Up

### Visual Design Pass
Use the frontend-design skill to restyle the rendered markdown. The current GitHub-inspired CSS is functional but clinical. Goals:
- Serif font for body text (monospace stays for code)
- Better spacing and padding
- Warmer, more readable aesthetic
- Preserve dark mode support and highlight.js integration
- Changes are in `Opsis/HTMLTemplate.swift` (inline CSS)

### Auto-Refresh on File Change
Watch the open file for modifications and re-render automatically. This is the core feature that makes Opsis useful as a live preview companion to any text editor.
- Use `DispatchSource.makeFileSystemObjectSource` or `NSFilePresenter`
- Debounce rapid saves (e.g., 200ms)
- Pairs with scroll position preservation (below)

### Custom UTType for Markdown Files
Register a proper UTType so Opsis appears in Finder's "Open With" for `.md` files. Currently declares `.plainText` which is too broad.
- Define UTType conforming to `public.plain-text` for `.md`, `.markdown`, `.mdown`
- Add `UTExportedTypeDeclarations` to Info.plist
- Update `MarkdownDocument.readableContentTypes`

## Future Ideas

### Scroll Position Preservation
When auto-refresh re-renders the document, maintain the user's scroll position instead of jumping to top.
- Save scroll offset via JavaScript before reload
- Restore after `didFinish` navigation
- Consider anchor-based restoration (find nearest heading)

### Quick Look Extension
Preview `.md` files in Finder without opening the app. Small scope, high user visibility.
- Thumbnail extension and/or preview extension
- Reuse `MarkdownRenderer` + `HTMLTemplate` pipeline

### Export to PDF/HTML
- Print support via WebView's built-in print
- Export rendered HTML as standalone file
- PDF export via WebView snapshot or print-to-PDF

### Document Outline / TOC
Sidebar showing heading structure with click-to-navigate.
- Parse headings from the HTML fragment or markdown AST
- SwiftUI sidebar with `NavigationSplitView`
- Scroll WebView to heading anchor on selection
