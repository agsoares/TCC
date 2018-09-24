import Foundation
import ObjectMapper

struct UserData: AutoMappable {
    var documentId: String = ""
    var balance: Double = 0.0

    init?(map: Map) { }
}
