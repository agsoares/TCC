import UIKit
import Firebase

class AppRouter: NSObject {

    static let shared = AppRouter()

    class func auth() -> AuthViewController {

        let viewModel = AuthViewModel(authService: AuthService())
        let viewController = AuthViewController(viewModel: viewModel)
        return viewController
    }

    class func home(user: User? = nil) -> UITabBarController {

        let dashViewModel = DashViewModel()
        let dashViewController = DashViewController(viewModel: dashViewModel)

        let viewControllers = [dashViewController, AppRouter.expensesChat()]

        let tabBarController = TabBarController(viewControllers: viewControllers.map {
            UINavigationController(rootViewController: $0)
        })

        tabBarController.delegate = AppRouter.shared

        return tabBarController
    }

    class func expensesChat() -> UIViewController {

        let viewModel = ExpenseViewModel()
        let viewController = ChatViewController()
        viewController.viewModel = viewModel

        return viewController
    }
}

extension AppRouter: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        if let navBar = viewController as? UINavigationController, navBar.viewControllers[0] is ChatViewController {

            let vc = UINavigationController(rootViewController: AppRouter.expensesChat())
            tabBarController.present(vc, animated: true, completion: nil)
            return false
        }
        return true
    }
}
