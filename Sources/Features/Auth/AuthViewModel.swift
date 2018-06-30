import Foundation
import RxSwift

class AuthViewModel: ViewModel {
    let authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

    func signIn(email: String, password: String) {
        authService.signUp(withEmail: email, andPassword: password)
            .subscribe(onNext: { globalState.value.user = $0 })
            .disposed(by: self.disposeBag)
    }
}
