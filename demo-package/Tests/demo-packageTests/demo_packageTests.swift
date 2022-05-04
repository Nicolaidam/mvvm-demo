import XCTest
@testable import demo_package

final class demo_packageTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(demo_package().text, "Hello, World!")
    }
}
