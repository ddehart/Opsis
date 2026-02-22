import SwiftUI
import WebKit

struct MarkdownWebView: View {
    let html: String

    @State private var page = WebPage()

    var body: some View {
        WebView(page)
            .task {
                page.load(html: html, baseURL: Bundle.main.resourceURL!)
            }
    }
}
