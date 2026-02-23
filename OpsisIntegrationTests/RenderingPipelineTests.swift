import Testing
@testable import Opsis

@Suite("Rendering Pipeline", .serialized)
@MainActor
struct RenderingPipelineTests {

    private func renderAndLoad(_ markdown: String) async throws -> WebViewTestHelper {
        let helper = WebViewTestHelper()
        let fragment = MarkdownRenderer.renderHTML(markdown)
        let html = HTMLTemplate.wrap(fragment)
        await helper.loadHTML(html)
        return helper
    }

    // MARK: - Core pipeline

    @Test func headingRendersInDOM() async throws {
        let helper = try await renderAndLoad("# Hello World")
        let text = try await helper.queryText("h1")
        #expect(text == "Hello World")
    }

    @Test func codeBlockHasLanguageClass() async throws {
        let helper = try await renderAndLoad("""
        ```swift
        let x = 1
        ```
        """)
        let exists = try await helper.queryExists("code.language-swift")
        #expect(exists)
    }

    @Test func highlightJSAppliesClasses() async throws {
        let helper = try await renderAndLoad("""
        ```swift
        let x = 1
        ```
        """)
        // highlight.js adds the "hljs" class after running highlightAll()
        let exists = try await helper.queryExists("code.hljs")
        #expect(exists)
    }

    // MARK: - GFM extensions in DOM

    @Test func tableRendersCorrectCells() async throws {
        let helper = try await renderAndLoad("""
        | A | B |
        |---|---|
        | 1 | 2 |
        """)
        let cellCount = try await helper.queryCount("td")
        #expect(cellCount == 2)
    }

    @Test func taskListRendersCheckboxes() async throws {
        let helper = try await renderAndLoad("""
        - [x] done
        - [ ] todo
        """)
        let checkboxCount = try await helper.queryCount("input[type='checkbox']")
        #expect(checkboxCount == 2)
    }

    @Test func linkHasCorrectHref() async throws {
        let helper = try await renderAndLoad("[text](https://example.com)")
        let href = try await helper.queryAttribute("a", attribute: "href")
        #expect(href == "https://example.com")
    }

    // MARK: - HTML template structure

    @Test func articleWrapsContent() async throws {
        let helper = try await renderAndLoad("Hello")
        let exists = try await helper.queryExists("article p")
        #expect(exists)
    }

    @Test func cssCustomPropertiesExist() async throws {
        let helper = try await renderAndLoad("Hello")
        let value = try await helper.evaluateJS(
            "getComputedStyle(document.documentElement).getPropertyValue('--text-color').trim()"
        ) as? String
        #expect(value != nil && !value!.isEmpty)
    }

    // MARK: - Full document smoke test

    @Test func fullDocumentStructure() async throws {
        let markdown = """
        # Main Heading

        A paragraph with **bold** and *italic*.

        ## Code Section

        ```swift
        print("hello")
        ```

        ## Table Section

        | Name | Value |
        |------|-------|
        | a    | 1     |
        | b    | 2     |

        - [x] Task one
        - [ ] Task two

        > A blockquote
        """
        let helper = try await renderAndLoad(markdown)

        let h1Count = try await helper.queryCount("h1")
        #expect(h1Count == 1)

        let h2Count = try await helper.queryCount("h2")
        #expect(h2Count == 2)

        let tableCount = try await helper.queryCount("table")
        #expect(tableCount == 1)

        let codeBlockCount = try await helper.queryCount("pre code")
        #expect(codeBlockCount == 1)

        let checkboxCount = try await helper.queryCount("input[type='checkbox']")
        #expect(checkboxCount == 2)

        let blockquoteCount = try await helper.queryCount("blockquote")
        #expect(blockquoteCount == 1)
    }
}
