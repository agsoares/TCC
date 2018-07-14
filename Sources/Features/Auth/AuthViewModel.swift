import Foundation
import RxSwift
import Firebase

class AuthViewModel: ViewModel {
    let authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

    func signIn() -> Observable<User> {

        return authService.singIn()
    }
}
