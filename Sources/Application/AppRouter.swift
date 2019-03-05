import UIKit
import Firebase

class AppRouter: NSObject {

    static let shared = AppRouter()

    class func auth() -> AuthViewController {
        let vm = AuthViewModel()
        return AuthViewController(viewModel: vm)
    }

    class func home(user: User? = nil) -> UITabBarController {

        let dashViewController = AppRouter.dashViewController(user: user)
        let expensesViewController = AppRouter.expensesChat()
        let configViewController = AppRouter.configViewController(user: user)

        let viewControllers = [dashViewController,
                               expensesViewController,
                               configViewController]

        let tabBarController = TabBarController(viewControllers: viewControllers.map {
            UINavigationController(rootViewController: $0)
        })

        tabBarController.delegate = AppRouter.shared

        return tabBarController
    }

    class func dashViewController(user: User? = nil) -> UIViewController {
        let viewModel = DashViewModel(user: user)
        let viewController = DashViewController(viewModel: viewModel)
        return viewController
    }

    class func expensesChat() -> UIViewController {
        let viewModel = ExpenseViewModel()
        let viewController = ChatViewController(viewModel: viewModel )

        return viewController
    }

    class func configViewController(user: User? = nil) -> UIViewController {
        //let viewModel = DashViewModel()
        let viewController = ConfigViewController()
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
