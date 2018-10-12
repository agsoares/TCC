import Foundation
import RxSwift

class ExpenseViewModel: ChatViewModel {
    var messageDataSource: Observable<[MessageData]>

    private let messages = BehaviorSubject<[MessageData]>(value: [])

    init() {

       messageDataSource = messages.asObserver()

       messages.onNext([
        MessageData(text: "text", isFromUser: false),
        MessageData(text: "Lorem ipsum dolor sit amet", isFromUser: true)
       ])
    }
}
