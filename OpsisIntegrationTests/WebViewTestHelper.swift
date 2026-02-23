import WebKit

@MainActor
final class WebViewTestHelper: NSObject, WKNavigationDelegate {
    private let webView: WKWebView
    private var navigationContinuation: CheckedContinuation<Void, Never>?

    override init() {
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 800, height: 600))
        super.init()
        webView.navigationDelegate = self
    }

    func loadHTML(_ html: String) async {
        await withCheckedContinuation { continuation in
            navigationContinuation = continuation
            webView.loadHTMLString(html, baseURL: nil)
        }
    }

    func evaluateJS(_ script: String) async throws -> Any? {
        try await webView.evaluateJavaScript(script)
    }

    func queryText(_ selector: String) async throws -> String? {
        let escaped = selector.replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "`", with: "\\`")
        return try await evaluateJS(
            "document.querySelector(`\(escaped)`)?.textContent"
        ) as? String
    }

    func queryCount(_ selector: String) async throws -> Int {
        let escaped = selector.replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "`", with: "\\`")
        let result = try await evaluateJS(
            "document.querySelectorAll(`\(escaped)`).length"
        )
        return (result as? Int) ?? 0
    }

    func queryExists(_ selector: String) async throws -> Bool {
        let escaped = selector.replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "`", with: "\\`")
        let result = try await evaluateJS(
            "document.querySelector(`\(escaped)`) !== null"
        )
        return (result as? Bool) ?? false
    }

    func queryAttribute(_ selector: String, attribute: String) async throws -> String? {
        let escapedSel = selector.replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "`", with: "\\`")
        let escapedAttr = attribute.replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "`", with: "\\`")
        return try await evaluateJS(
            "document.querySelector(`\(escapedSel)`)?.getAttribute(`\(escapedAttr)`)"
        ) as? String
    }

    // MARK: - WKNavigationDelegate

    nonisolated func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        MainActor.assumeIsolated {
            navigationContinuation?.resume()
            navigationContinuation = nil
        }
    }
}
