import Foundation
import RxSwift
import RxSwiftExt
import Firebase

class AuthViewModel {

    func bind(
        email: Observable<String?>,
        password: Observable<String?>,
        signInButton: Observable<Void>,
        signUpButton: Observable<Void>
    ) -> (
        isValid: Observable<Bool>,
        userLoggedIn: Observable<Event<User>>
    ) {
        let credentials = Observable.combineLatest(email, password)

        let isValid = credentials
            .map({ !($0.0?.isEmpty ?? true) && !($0.1?.isEmpty ?? true) })
            .startWith(false)

        let signIn = signInButton
            .withLatestFrom(credentials, resultSelector: { $1 })
            .flatMapLatest({ AuthService().signIn(withEmail: $0.0, andPassword: $0.1).materialize() })
            .share(replay: 1)

        let signUp = signUpButton
            .withLatestFrom(credentials, resultSelector: { $1 })
            .flatMapLatest({ AuthService().signUp(withEmail: $0.0, andPassword: $0.1).materialize() })
            .share(replay: 1)

        let userLoggedIn = Observable.merge(signIn, signUp)

        return (
            isValid: isValid,
            userLoggedIn: userLoggedIn
        )
    }
}
