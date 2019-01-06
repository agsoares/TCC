import Foundation
import XCoordinator

enum ChatRoute: Route {
    case expenses
    case dismiss
}

class ChatCoordinator: NavigationCoordinator<ChatRoute> {

    override func prepareTransition(for route: ChatRoute) -> NavigationTransition {
        switch route {

        case .expenses:
            let vm = ExpenseViewModel(router: self.anyRouter)
            let vc = ChatViewController(viewModel: vm)
            return .push(vc)
        case .dismiss:
            return .dismiss()
        }
    }
}
