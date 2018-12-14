import Foundation
import RxSwift
import RxSwiftExt
import Firebase

func authViewModel (
    email: Observable<String?>,
    password: Observable<String?>,
    signInButton: Observable<()>,
    signUpButton: Observable<()>
) -> (
    isValid: Observable<Bool>,
    userLoggedIn: Observable<User>
) {

    let credentials = Observable.combineLatest(email, password)
    let isValid = credentials
        .map({ !($0.0?.isEmpty ?? true) && !($0.1?.isEmpty ?? true) })
        .startWith(false)

    let signIn = signInButton
        .flatMap({ credentials })
        .flatMap({ AuthService().signIn(withEmail: $0.0, andPassword: $0.1) })

    let signUp = signUpButton
        .flatMap({ credentials })
        .flatMap({ AuthService().signUp(withEmail: $0.0, andPassword: $0.1) })


    let userLoggedIn = Observable.merge(signIn, signUp)

    return (
        isValid: isValid,
        userLoggedIn: userLoggedIn
    )
}
