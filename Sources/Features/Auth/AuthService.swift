import Foundation
import RxSwift
import FirebaseAuth

class AuthService {

    func signUp(withEmail email: String, andPassword password: String) -> Observable<User> {
        return Observable.create({ (observer) -> Disposable in

            Auth.auth().createUser(withEmail: email, password: password) { [weak globalState] (result, error) in
                if let error = error {
                    observer.onError(error)
                }
                if let result = result {

                    var state = globalState?.value ?? GlobalState()
                    state.user = result.user
                    globalState?.value = state

                    observer.onNext(result.user)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        })
    }

    func signIn(withEmail email: String, andPassword password: String) -> Observable<User> {
        return Observable.create({ (observer) -> Disposable in

            Auth.auth().signIn(withEmail: email, password: password) { [weak globalState] (result, error) in
                if let error = error {
                    observer.onError(error)
                }
                if let result = result {

                    var state = globalState?.value ?? GlobalState()
                    state.user = result.user
                    globalState?.value = state

                    observer.onNext(result.user)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        })
    }

}
