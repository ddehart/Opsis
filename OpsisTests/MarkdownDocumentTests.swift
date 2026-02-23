import Testing
import UniformTypeIdentifiers
@testable import Opsis

@Suite("MarkdownDocument")
struct MarkdownDocumentTests {

    @Test func defaultInitHasEmptyText() {
        let doc = MarkdownDocument()
        #expect(doc.text == "")
    }

    @Test func readableContentTypesIncludesMarkdown() {
        #expect(MarkdownDocument.readableContentTypes.contains(.markdown))
        #expect(!MarkdownDocument.readableContentTypes.contains(.plainText))
    }

    @Test func markdownTypeConformsToPlainText() {
        #expect(UTType.markdown.conforms(to: .plainText))
    }

    @Test func markdownTypeResolvesExpectedExtensions() {
        // .mdown is declared in the app's UTImportedTypeDeclarations and resolves
        // at runtime, but isn't testable here — unit tests have no host app.
        for ext in ["md", "markdown"] {
            let resolved = UTType(filenameExtension: ext)
            #expect(resolved != nil, "Extension .\(ext) should resolve to a UTType")
            #expect(resolved?.identifier == UTType.markdown.identifier, "Extension .\(ext) should resolve to the markdown UTType")
        }
    }

    @Test func textPropertyIsSettable() {
        var doc = MarkdownDocument()
        doc.text = "# Hello"
        #expect(doc.text == "# Hello")
    }
}
