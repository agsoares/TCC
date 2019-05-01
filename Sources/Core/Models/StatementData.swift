import ObjectMapper

struct StatementData: AutoMappable {
    var documentId: String = ""
    var dueDay: Date?

    var value: Double = 0.0
    var paidValue: Double = 0.0

    init?(map: Map) { }
}
