import Foundation

class AppRouter {

    class func loginViewController() -> LoginViewController {

        let reactor = LoginReactor()
        let viewController = LoginViewController()
        viewController.reactor = reactor
        return viewController
    }
}
