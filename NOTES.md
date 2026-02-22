# Opsis - Native macOS Markdown Viewer

## What This Is
A native macOS app for viewing rendered markdown files. Built because toggling preview in VS Code is annoying and Typora costs $15.

## Name
Opsis (ὄψις) - Ancient Greek for "sight" or "view."

## Requirements
- Open .md files and render them nicely
- Full GitHub-flavored markdown: tables, code blocks with syntax highlighting, task lists
- Dark mode support (follow system setting)
- Auto-refresh when the file changes on disk (so you can edit in VS Code and see updates live)
- macOS file associations so .md files can open with Opsis

## Technical Approach
- **SwiftUI** document-based app shell
- **WKWebView** for rendering (markdown → HTML → styled web view)
- **cmark** for markdown parsing (ships with macOS, no dependencies needed)
- **CSS** stylesheet for styling the rendered output
- Build with `xcodebuild` from the terminal

## Environment
- Swift 6.2.3
- Xcode 26.2
- macOS SDK 26.2
- Apple Silicon (arm64)

## Project Structure Convention
Standard Xcode project layout:
```
Opsis/
├── Opsis.xcodeproj/
├── Opsis/
│   ├── OpsisApp.swift
│   ├── ContentView.swift
│   ├── MarkdownRenderer.swift
│   ├── Assets.xcassets/
│   ├── Info.plist
│   └── preview.css
└── NOTES.md
```

## Workflow Tips (from experienced Mac app + Claude Code developers)

### Project Setup
- **Create a CLAUDE.md** in the project root with build commands, Swift conventions, and gotchas discovered along the way. This persists across sessions.
- **Use `xcodegen`** to generate .xcodeproj from a simple YAML config. Never let Claude edit .pbxproj files directly - it will corrupt them.
- **Use modern Swift patterns** in CLAUDE.md: `@Observable` (not `ObservableObject`), `NavigationStack` (not `NavigationView`), async/await (not completion handlers).

### During Development
- **Commit after every working change.** Claude will fix one thing and break another. Small commits make rollbacks trivial.
- **Use `--quiet` with xcodebuild.** Verbose build output floods the context window fast.
- **Start fresh sessions for distinct chunks of work.** Don't do everything in one marathon session.
- **Paste screenshots** of the running app into Claude Code for visual feedback. It can identify and fix UI issues from screenshots.
- **Add `os.Logger` statements** for complex flows - Claude can't interact with the running app, but it can read logs.

### Expectations
- Expect 2-3 rounds of "build → look at it → tell Claude what's wrong" before it feels right.
- Claude is great at scaffolding and fixing compiler errors, less great at pixel-perfect visual polish.
- Detailed specs beat vague requests.

## Repository Setup
```
cd ~/Developer/Opsis
git init
gh repo create Opsis --private --source=. --push
```
Requires `gh` CLI (`brew install gh` + `gh auth login` if not already set up).

## Goal
Build once, drop in /Applications, done. Personal use only - no signing or notarization needed.
