import Testing
@testable import Opsis

@Suite("MarkdownRenderer")
struct MarkdownRendererTests {

    // MARK: - Headings

    @Test("Headings h1 through h6", arguments: 1...6)
    func headings(level: Int) {
        let hashes = String(repeating: "#", count: level)
        let html = MarkdownRenderer.renderHTML("\(hashes) Heading")
        #expect(html.contains("<h\(level)>"))
        #expect(html.contains("</h\(level)>"))
    }

    // MARK: - Inline formatting

    @Test func paragraphs() {
        let html = MarkdownRenderer.renderHTML("Hello world")
        #expect(html.contains("<p>Hello world</p>"))
    }

    @Test func bold() {
        let html = MarkdownRenderer.renderHTML("**bold**")
        #expect(html.contains("<strong>bold</strong>"))
    }

    @Test func italic() {
        let html = MarkdownRenderer.renderHTML("*italic*")
        #expect(html.contains("<em>italic</em>"))
    }

    @Test func inlineCode() {
        let html = MarkdownRenderer.renderHTML("`code`")
        #expect(html.contains("<code>code</code>"))
    }

    // MARK: - Code blocks

    @Test func fencedCodeBlock() {
        let markdown = """
        ```swift
        let x = 1
        ```
        """
        let html = MarkdownRenderer.renderHTML(markdown)
        #expect(html.contains("<pre>"))
        #expect(html.contains("<code class=\"language-swift\">"))
    }

    // MARK: - Links and images

    @Test func links() {
        let html = MarkdownRenderer.renderHTML("[text](https://example.com)")
        #expect(html.contains("<a href=\"https://example.com\">text</a>"))
    }

    @Test func images() {
        let html = MarkdownRenderer.renderHTML("![alt](image.png)")
        #expect(html.contains("<img"))
        #expect(html.contains("src=\"image.png\""))
        #expect(html.contains("alt=\"alt\""))
    }

    // MARK: - Block elements

    @Test func blockquotes() {
        let html = MarkdownRenderer.renderHTML("> quote")
        #expect(html.contains("<blockquote>"))
    }

    @Test func unorderedList() {
        let markdown = """
        - one
        - two
        """
        let html = MarkdownRenderer.renderHTML(markdown)
        #expect(html.contains("<ul>"))
        #expect(html.contains("<li>"))
    }

    @Test func orderedList() {
        let markdown = """
        1. first
        2. second
        """
        let html = MarkdownRenderer.renderHTML(markdown)
        #expect(html.contains("<ol>"))
        #expect(html.contains("<li>"))
    }

    // MARK: - GFM extensions

    @Test func tables() {
        let markdown = """
        | A | B |
        |---|---|
        | 1 | 2 |
        """
        let html = MarkdownRenderer.renderHTML(markdown)
        #expect(html.contains("<table>"))
        #expect(html.contains("<th>"))
        #expect(html.contains("<td>"))
    }

    @Test func taskListChecked() {
        let markdown = """
        - [x] done
        """
        let html = MarkdownRenderer.renderHTML(markdown)
        #expect(html.contains("<input type=\"checkbox\""))
        #expect(html.contains("checked"))
    }

    @Test func taskListUnchecked() {
        let markdown = """
        - [ ] todo
        """
        let html = MarkdownRenderer.renderHTML(markdown)
        #expect(html.contains("<input type=\"checkbox\""))
        #expect(!html.contains("checked=\"\""))
    }

    @Test func autolinks() {
        let html = MarkdownRenderer.renderHTML("https://example.com")
        #expect(html.contains("<a href=\"https://example.com\">"))
    }

    @Test func strikethroughDoubleTildeInline() {
        let html = MarkdownRenderer.renderHTML("text ~~deleted~~ end")
        #expect(html.contains("<del>"))
    }

    @Test func strikethroughSingleTilde() {
        let html = MarkdownRenderer.renderHTML("~deleted~")
        #expect(html.contains("<del>"))
    }

    // MARK: - Smart typography

    @Test func smartEnDash() {
        let html = MarkdownRenderer.renderHTML("a -- b")
        #expect(html.contains("\u{2013}")) // en-dash
    }

    @Test func smartCurlyQuotes() {
        let html = MarkdownRenderer.renderHTML("\"hello\"")
        #expect(html.contains("\u{201C}") || html.contains("\u{201D}")) // curly quotes
    }

    // MARK: - Edge cases

    @Test func emptyString() {
        let html = MarkdownRenderer.renderHTML("")
        #expect(html.isEmpty || html.allSatisfy(\.isWhitespace))
    }

    @Test func onlyWhitespace() {
        let html = MarkdownRenderer.renderHTML("   \n\n   ")
        #expect(!html.contains("<p>"))
    }

    @Test func unicodeContent() {
        let html = MarkdownRenderer.renderHTML("# \u{1F600} Emoji heading")
        #expect(html.contains("<h1>"))
        #expect(html.contains("\u{1F600}"))
    }
}
