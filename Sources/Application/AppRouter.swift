import Foundation

class AppRouter {

    class func loginViewController() -> AuthViewController {

        let reactor = AuthReactor()
        let viewController = AuthViewController()
        viewController.reactor = reactor
        return viewController
    }
    
}
