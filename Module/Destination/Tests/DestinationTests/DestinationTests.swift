import XCTest
@testable import Destination

final class DestinationTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Destination().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample)
    ]
}
