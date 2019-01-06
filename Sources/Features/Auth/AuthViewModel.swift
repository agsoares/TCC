import Foundation
import XCoordinator
import RxSwift
import RxSwiftExt
import Firebase

class AuthViewModel {

    let router: AnyRouter<AppRoute>

    init(router: AnyRouter<AppRoute>) {
        self.router = router
    }

    func bind(
        email: Observable<String?>,
        password: Observable<String?>,
        signInButton: Observable<()>,
        signUpButton: Observable<()>
    ) -> (
        isValid: Observable<Bool>,
        userLoggedIn: Observable<Void>
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
            .do(onNext: { [weak self] event in
                switch event {
                case .next(let user):
                    self?.router.trigger(.home(user))
                case .error(let error):
                    self?.router.showError(message: error.localizedDescription)
                default:
                    break
                }
            })
            .mapTo(())

        return (
            isValid: isValid,
            userLoggedIn: userLoggedIn
        )
    }
}
