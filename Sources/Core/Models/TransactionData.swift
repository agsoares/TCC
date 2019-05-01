import ObjectMapper

struct TransactionData: AutoMappable {
    var documentId: String = ""
    var description: String?
    var date: Date?

    var value: Double = 0.0

    init?(map: Map) { }
}
