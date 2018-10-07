import Foundation
import RxSwift
import Firebase

class AuthViewModel {
    let authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

    func signUp(withEmail email: String?, andPassword password: String?) -> Observable<User> {

        return authService.signUp(withEmail: email, andPassword: password)
    }

    func signIn(withEmail email: String?, andPassword password: String?) -> Observable<User> {

        return authService.signIn(withEmail: email, andPassword: password)
    }
}
