import ObjectMapper

struct CardData: AutoMappable {
    var documentId: String = ""
    var name: String?

    var closingDay: Int = 0
    var dueDay: Int = 0

    var limit: Double = 0.0
    var owedValue: Double = 0.0
    var usedLimit: Double = 0.0

    init?(map: Map) { }
}
