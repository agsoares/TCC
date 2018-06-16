// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length trailing_whitespace
import ObjectMapper

extension User {
    enum Parameter: String {
        case id 
    }

    mutating func mapping(map: Map) {
        id <- map[Parameter.id.rawValue]
    }
}
