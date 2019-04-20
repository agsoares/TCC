import Foundation
import RxDataSources
import RxSwift

// TODO: ExpenseFlow

class ExpenseViewModel: ChatViewModel {

    func bind(
        didSendMessage: Observable<String?>
    ) -> (
        messagesDatasource: Observable<[MessageSection]>,
        viewControllerEvents: Observable<Void>
    ) {

        let messageData = [
            MessageData(text: "text", isFromUser: false),
            MessageData(text: "Lorem ipsum dolor sit amet", isFromUser: true)
        ]
        .map({ MessageCellItem(messageData: $0) })

        return (
            messagesDatasource: Observable<[MessageSection]>.just([MessageSection(model: "", items: messageData)]),
            viewControllerEvents: Observable<Void>.never()
        )
    }
}
