// Generated using Sourcery 0.16.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length trailing_whitespace
import ObjectMapper

extension AccountData {
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

extension CardData {
    enum Parameter: String {
        case documentId 
        case name 
        case closingDay 
        case dueDay 
        case limit 
        case usedLimit 
    }

    mutating func mapping(map: Map) {
        documentId <- map[Parameter.documentId.rawValue]
        name <- map[Parameter.name.rawValue]
        closingDay <- map[Parameter.closingDay.rawValue]
        dueDay <- map[Parameter.dueDay.rawValue]
        limit <- map[Parameter.limit.rawValue]
        usedLimit <- map[Parameter.usedLimit.rawValue]
    }
}

extension StatementData {
    enum Parameter: String {
        case documentId 
        case dueDay 
        case value 
        case paidValue 
    }

    mutating func mapping(map: Map) {
        documentId <- map[Parameter.documentId.rawValue]
        dueDay <- map[Parameter.dueDay.rawValue]
        value <- map[Parameter.value.rawValue]
        paidValue <- map[Parameter.paidValue.rawValue]
    }
}

extension TransactionData {
    enum Parameter: String {
        case documentId 
        case description 
        case date 
        case value 
    }

    mutating func mapping(map: Map) {
        documentId <- map[Parameter.documentId.rawValue]
        description <- map[Parameter.description.rawValue]
        date <- map[Parameter.date.rawValue]
        value <- map[Parameter.value.rawValue]
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
