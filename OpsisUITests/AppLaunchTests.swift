import XCTest

@MainActor
final class AppLaunchTests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() async throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDown() async throws {
        app.terminate()
    }

    func testAppLaunches() {
        app.launch()
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 5))
    }

    func testDocumentShowsContent() throws {
        app.launch()
        let fixtureURL = try fixtureFileURL()
        app.open(fixtureURL)

        let heading = app.webViews.staticTexts["Test Document"]
        XCTAssertTrue(
            heading.waitForExistence(timeout: 10),
            "Expected heading 'Test Document' to appear in the WebView"
        )
    }

    func testWebViewHasRenderedText() throws {
        app.launch()
        let fixtureURL = try fixtureFileURL()
        app.open(fixtureURL)

        let webView = app.webViews.firstMatch
        XCTAssertTrue(
            webView.waitForExistence(timeout: 10),
            "Expected a WebView to appear after opening a document"
        )
        XCTAssertTrue(
            app.webViews.staticTexts.count > 0,
            "Expected rendered text content inside the WebView"
        )
    }

    // MARK: - Helpers

    private func fixtureFileURL() throws -> URL {
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: "test", withExtension: "md", subdirectory: "Fixtures") {
            return url
        }
        if let url = bundle.url(forResource: "test", withExtension: "md") {
            return url
        }
        throw XCTSkip("test.md fixture not found in UI test bundle")
    }
}
