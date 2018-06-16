// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import ObjectMapper

extension User {
    enum Parameter: String {
        case id = "teste" 
    }

    mutating func mapping(map: Map) {
        id <- map[Parameter.id.rawValue]
    }
}
