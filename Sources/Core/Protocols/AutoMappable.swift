import ObjectMapper
import Firebase

protocol AutoMappable: Mappable { }

extension AutoMappable {
    init?(snapshot: DocumentSnapshot) {
        guard var json = snapshot.data() else {
            return nil
        }
        json["documentId"] = snapshot.documentID
        self.init(JSON: json)
    }
}
