import Foundation
import ObjectMapper

struct UserData: AutoMappable {

    var balance: Double = 0.0

    init?(map: Map) { }
}
