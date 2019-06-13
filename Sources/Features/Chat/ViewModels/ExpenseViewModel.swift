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
        shouldShowTextField: Observable<InputType>,
        textFieldValue: Observable<String>,
        viewControllerEvents: Observable<Void>
    ) {

        chatState = ExpenseFlow.initial

        let messageData = [
            MessageData(text: "Olá :)", isFromUser: false),
            MessageData(text: "Qual o tipo de transação que você quer registrar?", isFromUser: false),
            MessageData(text: "Despesa", isFromUser: true),
            MessageData(text: "Qual o valor da despesa?", isFromUser: false)
        ]
        .map({ MessageCellItem(messageData: $0) })

        let textFieldValue = didChangeText
            .map({ [weak self] text in self?.formatText(text) ?? "" })

        return (
            messagesDatasource: Observable<[MessageSection]>.just([MessageSection(model: "", items: messageData)]),
            shouldShowTextField: Observable<InputType>.just(InputType.textField(keyboard: .numberPad, placeholder: "R$ 0,00")), //.just(.buttons([ChatButton(text: "Receita", answer: ""), ChatButton(text: "Despesa", answer: ""), ChatButton(text: "Transferência", answer: "")])),
            textFieldValue: textFieldValue,
            viewControllerEvents: Observable<Void>.never()
        )
    }
}
