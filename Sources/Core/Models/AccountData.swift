import Foundation
import ObjectMapper

struct AccountData: AutoMappable {
    var documentId: String = ""
    var name: String?
    var balance: Double = 0.0

    init?(map: Map) { }
}
