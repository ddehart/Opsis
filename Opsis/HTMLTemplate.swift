import Foundation

enum HTMLTemplate {
    private static let highlightJS: String = {
        guard let url = Bundle.main.url(forResource: "highlight.min", withExtension: "js"),
              let js = try? String(contentsOf: url, encoding: .utf8) else {
            return ""
        }
        return js
    }()

    private static let lightCSS: String = {
        guard let url = Bundle.main.url(forResource: "highlight-light.min", withExtension: "css"),
              let css = try? String(contentsOf: url, encoding: .utf8) else {
            return ""
        }
        return css
    }()

    private static let darkCSS: String = {
        guard let url = Bundle.main.url(forResource: "highlight-dark.min", withExtension: "css"),
              let css = try? String(contentsOf: url, encoding: .utf8) else {
            return ""
        }
        return css
    }()

    static func wrap(_ htmlFragment: String) -> String {
        """
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="utf-8">
        <meta name="color-scheme" content="light dark">
        <style>
        :root {
            --text-color: #1f2328;
            --bg-color: #ffffff;
            --link-color: #0969da;
            --border-color: #d0d7de;
            --blockquote-color: #656d76;
            --code-bg: #eff1f3;
            --table-border: #d0d7de;
            --table-alt-bg: #f6f8fa;
        }
        @media (prefers-color-scheme: dark) {
            :root {
                --text-color: #e6edf3;
                --bg-color: #0d1117;
                --link-color: #4493f8;
                --border-color: #3d444d;
                --blockquote-color: #9198a1;
                --code-bg: #161b22;
                --table-border: #3d444d;
                --table-alt-bg: #161b22;
            }
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            font-size: 16px;
            line-height: 1.6;
            color: var(--text-color);
            background-color: var(--bg-color);
            max-width: 880px;
            margin: 0 auto;
            padding: 32px;
        }
        a { color: var(--link-color); text-decoration: none; }
        a:hover { text-decoration: underline; }
        h1, h2, h3, h4, h5, h6 { margin-top: 24px; margin-bottom: 16px; font-weight: 600; }
        h1 { font-size: 2em; border-bottom: 1px solid var(--border-color); padding-bottom: 0.3em; }
        h2 { font-size: 1.5em; border-bottom: 1px solid var(--border-color); padding-bottom: 0.3em; }
        h3 { font-size: 1.25em; }
        h4 { font-size: 1em; }
        h5 { font-size: 0.875em; }
        h6 { font-size: 0.85em; color: var(--blockquote-color); }
        p { margin-top: 0; margin-bottom: 16px; }
        code {
            font-family: ui-monospace, SFMono-Regular, "SF Mono", Menlo, monospace;
            font-size: 85%;
            background-color: var(--code-bg);
            padding: 0.2em 0.4em;
            border-radius: 6px;
        }
        pre {
            background-color: var(--code-bg);
            padding: 16px;
            border-radius: 6px;
            overflow-x: auto;
            line-height: 1.45;
        }
        pre code { background: none; padding: 0; font-size: 85%; }
        blockquote {
            margin: 0 0 16px 0;
            padding: 0 1em;
            color: var(--blockquote-color);
            border-left: 0.25em solid var(--border-color);
        }
        table { border-collapse: collapse; width: 100%; margin: 16px 0; }
        th, td { border: 1px solid var(--table-border); padding: 6px 13px; }
        tr:nth-child(even) { background-color: var(--table-alt-bg); }
        th { font-weight: 600; }
        img { max-width: 100%; }
        hr { border: none; border-top: 1px solid var(--border-color); margin: 24px 0; }
        li:has(> input[type="checkbox"]) {
            list-style: none;
            margin-left: -1.5em;
        }
        li > input[type="checkbox"] {
            margin-right: 0.4em;
            pointer-events: none;
        }
        \(lightCSS)
        @media (prefers-color-scheme: dark) {
        \(darkCSS)
        }
        </style>
        </head>
        <body>
        <article>
        \(htmlFragment)
        </article>
        <script>\(highlightJS)</script>
        <script>hljs.highlightAll();</script>
        </body>
        </html>
        """
    }
}
