// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length trailing_whitespace
import ObjectMapper

extension AccountsData {
    enum Parameter: String {
        case documentId 
        case name 
        case balance 
    }

    mutating func mapping(map: Map) {
        documentId <- map[Parameter.documentId.rawValue]
        name <- map[Parameter.name.rawValue]
        balance <- map[Parameter.balance.rawValue]
    }
}

extension UserData {
    enum Parameter: String {
        case documentId 
        case balance 
    }

    mutating func mapping(map: Map) {
        documentId <- map[Parameter.documentId.rawValue]
        balance <- map[Parameter.balance.rawValue]
    }
}
