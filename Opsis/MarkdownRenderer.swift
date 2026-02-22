import CMarkGFM
import Foundation
import os

enum MarkdownRenderer {
    private static let lock = OSAllocatedUnfairLock()

    static func renderHTML(_ markdown: String) -> String {
        lock.withLock {
            cmark_gfm_core_extensions_ensure_registered()

            let options = CMARK_OPT_UNSAFE | CMARK_OPT_SMART

            guard let parser = cmark_parser_new(options) else {
                return ""
            }

            let extensionNames = ["table", "autolink", "strikethrough", "tasklist", "tagfilter"]
            for name in extensionNames {
                if let ext = cmark_find_syntax_extension(name) {
                    cmark_parser_attach_syntax_extension(parser, ext)
                }
            }

            let utf8Count = markdown.utf8.count
            markdown.withCString { buffer in
                cmark_parser_feed(parser, buffer, utf8Count)
            }

            guard let document = cmark_parser_finish(parser) else {
                cmark_parser_free(parser)
                return ""
            }

            let extensions = cmark_parser_get_syntax_extensions(parser)

            guard let cString = cmark_render_html(document, options, extensions) else {
                cmark_node_free(document)
                cmark_parser_free(parser)
                return ""
            }

            let html = String(cString: cString)
            free(cString)
            cmark_node_free(document)
            cmark_parser_free(parser)

            return html
        }
    }
}
