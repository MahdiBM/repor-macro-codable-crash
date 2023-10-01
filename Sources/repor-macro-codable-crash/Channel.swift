public struct DiscordChannel {
    public struct Message {
        public struct Activity: Sendable, Codable {

            /// https://discord.com/developers/docs/resources/channel#message-object-message-activity-types
            @UnstableEnum<Int>
            public enum Kind: Sendable, Codable {
                case join // 1
                case spectate // 2
                case listen // 3
                case joinRequest // 5
            }

            public var type: Kind
            /// Not a Snowflake. Example: `spotify:715622804258684938`.
            public var party_id: String?
        }
    }
}
