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
            --text-color: #2c2825;
            --bg-color: #faf8f5;
            --link-color: #3b6ea5;
            --border-color: #ddd7cf;
            --blockquote-color: #7d766d;
            --code-bg: #f0ede7;
            --code-border: #e0dbd4;
            --table-border: #ddd7cf;
            --table-alt-bg: #f4f1ec;
        }
        @media (prefers-color-scheme: dark) {
            :root {
                --text-color: #e0dbd4;
                --bg-color: #1c1b19;
                --link-color: #7fb5e0;
                --border-color: #3a3633;
                --blockquote-color: #9b9489;
                --code-bg: #252220;
                --code-border: #3a3633;
                --table-border: #3a3633;
                --table-alt-bg: #222019;
            }
        }
        body {
            font-family: Charter, "Iowan Old Style", Palatino, Georgia, serif;
            font-size: 17px;
            line-height: 1.75;
            color: var(--text-color);
            background-color: var(--bg-color);
            max-width: 720px;
            margin: 0 auto;
            padding: 48px 40px;
            -webkit-font-smoothing: antialiased;
            hanging-punctuation: first last;
            font-feature-settings: "liga" 1, "clig" 1, "kern" 1, "onum" 1;
        }
        a {
            color: var(--link-color);
            text-decoration: underline;
            text-decoration-color: color-mix(in srgb, var(--link-color) 40%, transparent);
            text-underline-offset: 0.15em;
        }
        a:hover {
            text-decoration-color: var(--link-color);
        }
        h1, h2, h3, h4, h5, h6 {
            font-family: -apple-system, "Helvetica Neue", sans-serif;
            margin-top: 40px;
            margin-bottom: 12px;
            font-weight: 600;
            line-height: 1.3;
        }
        h1 {
            font-size: 1.8em;
            font-weight: 700;
            letter-spacing: -0.02em;
            margin-bottom: 16px;
        }
        h2 {
            font-size: 1.4em;
            padding-top: 8px;
        }
        h3 { font-size: 1.15em; }
        h4 { font-size: 1em; }
        h5 { font-size: 0.9em; text-transform: uppercase; letter-spacing: 0.05em; font-weight: 600; }
        h6 { font-size: 0.85em; font-variant: small-caps; letter-spacing: 0.03em; color: var(--blockquote-color); }
        p { margin-top: 0; margin-bottom: 20px; }
        code {
            font-family: ui-monospace, SFMono-Regular, "SF Mono", Menlo, monospace;
            font-size: 83%;
            background-color: var(--code-bg);
            padding: 0.15em 0.35em;
            border-radius: 4px;
            border: 1px solid var(--code-border);
            font-feature-settings: "liga" 0, "onum" 0;
        }
        pre {
            background-color: var(--code-bg);
            padding: 20px;
            border-radius: 8px;
            border: 1px solid var(--code-border);
            overflow-x: auto;
            line-height: 1.5;
        }
        pre code {
            background: none;
            padding: 0;
            font-size: 83%;
            border: none;
        }
        blockquote {
            margin: 0 0 20px 0;
            padding: 0.5em 1.2em;
            color: var(--blockquote-color);
            font-style: italic;
            quotes: "\\201C" "\\201D";
        }
        blockquote::before {
            content: open-quote;
            font-size: 3em;
            font-family: Charter, Georgia, serif;
            color: var(--border-color);
            line-height: 0.1em;
            margin-right: 0.15em;
            vertical-align: -0.4em;
        }
        blockquote p:first-child {
            display: inline;
        }
        blockquote code { font-style: normal; }
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 24px 0;
            font-size: 0.92em;
        }
        th, td {
            border-bottom: 1px solid var(--table-border);
            padding: 10px 16px;
            text-align: left;
        }
        th {
            font-family: -apple-system, "Helvetica Neue", sans-serif;
            font-weight: 600;
            font-size: 0.85em;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            border-bottom-width: 2px;
        }
        tr:nth-child(even) { background-color: var(--table-alt-bg); }
        img { max-width: 100%; border-radius: 4px; }
        hr {
            border: none;
            margin: 48px 0;
            height: 1.5em;
            position: relative;
            outline: 0;
            text-align: center;
        }
        hr::before {
            content: "";
            background: linear-gradient(to right, transparent, var(--border-color), transparent);
            position: absolute;
            left: 0;
            top: 50%;
            width: 100%;
            height: 1px;
        }
        hr::after {
            content: "\\2726";
            display: inline-block;
            position: relative;
            padding: 0 0.6em;
            line-height: 1.5em;
            color: var(--blockquote-color);
            background: var(--bg-color);
            font-size: 0.85em;
        }
        ul, ol { padding-left: 1.5em; }
        li { margin-bottom: 0.3em; }
        li:has(> input[type="checkbox"]) {
            list-style: none;
            margin-left: -1.5em;
        }
        li > input[type="checkbox"] {
            margin-right: 0.4em;
            pointer-events: none;
        }
        strong { font-weight: 700; }
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
