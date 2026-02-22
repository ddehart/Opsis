import SwiftUI

struct ContentView: View {
    let document: MarkdownDocument

    var body: some View {
        MarkdownWebView(html: renderedHTML)
    }

    private var renderedHTML: String {
        let fragment = MarkdownRenderer.renderHTML(document.text)
        return HTMLTemplate.wrap(fragment)
    }
}
