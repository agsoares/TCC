import Foundation
import RxSwift

class ExpenseViewModel: ChatViewModel {
    var messageDataSource: Observable<[MessageSection]>

    private let messages = BehaviorSubject<[MessageSection]>(value: [])

    init() {

        messageDataSource = messages.asObserver()

        let messageData = [
            MessageData(text: "text", isFromUser: false),
            MessageData(text: "Lorem ipsum dolor sit amet", isFromUser: true)
        ]
        .map({ MessageDataItem(messageData: $0) })

        messages.onNext([ MessageSection(model: "", items: messageData ) ])

    }
}
