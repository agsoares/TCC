import Foundation
import RxDataSources
import RxSwift

class ExpenseViewModel: ChatViewModel {

    var chatState: ChatState?

    func bind(
        viewDidAppear: Observable<Void>,
        didChangeText: Observable<String?>,
        didSendMessage: Observable<String?>
    ) -> (
        messagesDatasource: Observable<[MessageSection]>,
        shouldShowTextField: Observable<Bool>,
        textFieldValue: Observable<String>,
        viewControllerEvents: Observable<Void>
    ) {

        chatState = ExpenseFlow.other

        let messageData = [
            MessageData(text: "text", isFromUser: false),
            MessageData(text: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet", isFromUser: true)
        ]
        .map({ MessageCellItem(messageData: $0) })

        let textFieldValue = didChangeText
            .map({ [weak self] text in self?.formatText(text) ?? "" })

        return (
            messagesDatasource: Observable<[MessageSection]>.just([MessageSection(model: "", items: messageData)]),
            shouldShowTextField: Observable<Bool>.just(true),
            textFieldValue: textFieldValue,
            viewControllerEvents: Observable<Void>.never()
        )
    }
}
