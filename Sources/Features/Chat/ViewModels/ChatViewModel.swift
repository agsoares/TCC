import Foundation
import RxSwift
import RxDataSources

enum FormatterType {
    case currency
    case none
}

enum InputType {
    case textField(keyboard:UIKeyboardType, placeholder: String)
    case buttons([ChatButton])
    case none
}

struct ChatButton {
    var text: String
    var answer: String
}

protocol ChatState {

    var formatter: FormatterType { get }
}

protocol ChatViewModel {
    typealias MessageSection = SectionModel<String, CellItem>

    var chatState: ChatState? { get set }

    func bind(
        viewDidAppear: Observable<Void>,
        didChangeText: Observable<String?>,
        didSendMessage: Observable<String?>
    ) -> (
        messagesDatasource: Observable<[MessageSection]>,
        shouldShowTextField: Observable<InputType>,
        textFieldValue: Observable<String>,
        viewControllerEvents: Observable<Void>
    )
}

extension ChatViewModel {

    func formatText(_ text: String?) -> String {

        switch chatState?.formatter {
        case .currency?:
            guard let val = text?.doubleFromCurrency() else { return "" }
            return val.currency() ?? ""
        case .none?:
            return text ?? ""
        default:
            return text ?? ""
        }
    }
}
