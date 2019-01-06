import Foundation
import XCoordinator
import Firebase

enum AppRoute: Route {
    case login
    case home(User)
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    var homeCoordinator: HomeCoordinator?

    init() {
        FirebaseApp.configure()

        let initialRoute: AppRoute
        if let firebaseUser = Auth.auth().currentUser {
            initialRoute = .home(firebaseUser)
        } else {
            initialRoute = .login
        }

        super.init(initialRoute: initialRoute)
    }

    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .home(let user):
            let homeCoordinator = HomeCoordinator(user: user)
            self.homeCoordinator = homeCoordinator
            return .present(homeCoordinator)

        case .login:
            let vm = AuthViewModel(router: self.anyRouter)
            let vc = AuthViewController(viewModel: vm)
            return .push(vc)
        }
    }

}
