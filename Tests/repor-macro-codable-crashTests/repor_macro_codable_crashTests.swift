@testable import repor_macro_codable_crash
import XCTest

final class repor_macro_codable_crashTests: XCTestCase {
   
    func testCrash() throws {
        let text = "{}"
        let data = Data(text.utf8)
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(MessageCreate.self, from: data)
    }
}
