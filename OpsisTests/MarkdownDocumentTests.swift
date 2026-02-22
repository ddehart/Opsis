import Testing
import UniformTypeIdentifiers
@testable import Opsis

@Suite("MarkdownDocument")
struct MarkdownDocumentTests {

    @Test func defaultInitHasEmptyText() {
        let doc = MarkdownDocument()
        #expect(doc.text == "")
    }

    @Test func readableContentTypesIncludesPlainText() {
        #expect(MarkdownDocument.readableContentTypes.contains(.plainText))
    }

    @Test func textPropertyIsSettable() {
        var doc = MarkdownDocument()
        doc.text = "# Hello"
        #expect(doc.text == "# Hello")
    }
}
