import SwiftUI

struct ContentView: View {
    let document: MarkdownDocument

    var body: some View {
        Text("Markdown content will render here")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.title2)
            .foregroundStyle(.secondary)
    }
}
