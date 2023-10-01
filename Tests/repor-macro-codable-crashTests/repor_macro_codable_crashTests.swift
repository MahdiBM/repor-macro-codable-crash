@testable import repor_macro_codable_crash
import XCTest

class repor_macro_codable_crashTests: XCTestCase {
   
    func testCrash() throws {
        let text = """
        {
                "type": 0,
                "tts": false,
                "timestamp": "2022-10-07T19:44:07.295000+00:00",
                "pinned": false,
                "nonce": "1028029979960541184",
                "mentions": [],
                "mention_roles": [],
                "mention_everyone": false,
                "id": "1028029980795478046",
                "flags": 0,
                "embeds": [],
                "edited_timestamp": null,
                "content": "blah bljhshADh blah",
                "components": [],
                "channel_id": "435923868503506954",
                "attachments": [],
                "guild_id": "439103874612675485"
                }
        """
        let data = Data(text.utf8)
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(MessageCreate.self, from: data)

        XCTFail("DID NOT CRASH?!")
    }
}
