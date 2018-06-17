import Foundation

class AppRouter {

    class func loginViewController() -> AuthViewController {

        let reactor = AuthReactor(authService: AuthService())
        let viewController = AuthViewController()
        viewController.reactor = reactor
        return viewController
    }

}
