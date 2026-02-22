import Testing
@testable import Opsis

@Suite("HTMLTemplate")
struct HTMLTemplateTests {

    private let output = HTMLTemplate.wrap("<p>Hello</p>")

    // MARK: - Document structure

    @Test func containsDoctype() {
        #expect(output.contains("<!DOCTYPE html>"))
    }

    @Test func containsHTMLTags() {
        #expect(output.contains("<html>"))
        #expect(output.contains("</html>"))
    }

    @Test func containsHeadAndBody() {
        #expect(output.contains("<head>"))
        #expect(output.contains("</head>"))
        #expect(output.contains("<body>"))
        #expect(output.contains("</body>"))
    }

    @Test func wrapsContentInArticle() {
        #expect(output.contains("<article>"))
        #expect(output.contains("<p>Hello</p>"))
        #expect(output.contains("</article>"))
    }

    // MARK: - Meta tags

    @Test func colorSchemeMeta() {
        #expect(output.contains("<meta name=\"color-scheme\" content=\"light dark\">"))
    }

    @Test func charsetMeta() {
        #expect(output.contains("<meta charset=\"utf-8\">"))
    }

    // MARK: - CSS custom properties

    @Test func lightModeCustomProperties() {
        #expect(output.contains("--text-color"))
        #expect(output.contains("--bg-color"))
        #expect(output.contains("--link-color"))
        #expect(output.contains("--border-color"))
        #expect(output.contains("--blockquote-color"))
        #expect(output.contains("--code-bg"))
        #expect(output.contains("--table-border"))
        #expect(output.contains("--table-alt-bg"))
    }

    @Test func darkModeMediaQuery() {
        #expect(output.contains("@media (prefers-color-scheme: dark)"))
    }

    // MARK: - Highlight.js integration

    @Test func highlightJSScript() {
        #expect(output.contains("<script>"))
        #expect(output.contains("hljs.highlightAll()"))
    }

    // MARK: - Content passthrough

    @Test func passesFragmentThrough() {
        let custom = HTMLTemplate.wrap("<h1>Title</h1><p>Body</p>")
        #expect(custom.contains("<h1>Title</h1><p>Body</p>"))
    }

    @Test func handlesEmptyFragment() {
        let empty = HTMLTemplate.wrap("")
        #expect(empty.contains("<!DOCTYPE html>"))
        #expect(empty.contains("<article>"))
    }
}
