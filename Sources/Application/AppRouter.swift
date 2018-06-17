import Foundation

class AppRouter {

    class func loginViewController() -> AuthViewController {

        let viewModel = AuthViewModel(authService: AuthService())
        let viewController = AuthViewController(viewModel: viewModel)
        return viewController
    }
}
