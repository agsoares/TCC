import UIKit
import Firebase

class AppRouter {

    class func auth() -> AuthViewController {

        let viewModel = AuthViewModel(authService: AuthService())
        let viewController = AuthViewController(viewModel: viewModel)
        return viewController
    }

    class func home(user: User? = nil) -> UITabBarController {

        let dashViewModel = DashViewModel()
        let dashViewController = DashViewController(viewModel: dashViewModel)

        let viewControllers = [dashViewController]

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers.map { UINavigationController(rootViewController: $0) }

        return tabBarController
    }

    class func expensesChat() -> UIViewController {

        let viewModel = ExpenseViewModel()
        let viewController = ChatViewController()
        viewController.viewModel = viewModel

        return viewController
    }

}
