import Foundation
import FirebaseAuth

struct GlobalState {
    var user: User?

    init() {
        user = Auth.auth().currentUser
    }
}
