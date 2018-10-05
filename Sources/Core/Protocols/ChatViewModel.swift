import Foundation
import RxSwift

struct MessageData {
    let text: String
    let isFromUser: Bool
}

protocol ChatViewModel {

    var messageDataSource: Observable<[MessageData]> { get set }
}
