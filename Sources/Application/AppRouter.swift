import UIKit

class AppRouter {

    class func auth() -> AuthViewController {

        let viewModel = AuthViewModel(authService: AuthService())
        let viewController = AuthViewController(viewModel: viewModel)
        return viewController
    }

    class func home() -> UITabBarController {

        let dashViewModel = DashViewModel()
        let dashViewController = DashViewController()

        let viewControllers = [dashViewController]

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers.map { UINavigationController(rootViewController: $0) }

        return tabBarController
    }

}
