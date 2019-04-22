import Foundation

enum ExpenseFlow: ChatState {
    case initial
    case other

    var formatter: FormatterType {
        switch self {
        case .initial:
            return .currency
        default:
            return .none
        }
    }
}
