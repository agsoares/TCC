import Foundation
import RxSwift
import FirebaseAuth

class AuthService {

    func createUser(withEmail email: String, andPassword password: String) -> Observable<User> {
        return Observable.create({ (observer) -> Disposable in

            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    observer.onError(error)
                }
                if let result = result {
                    observer.onNext(result.user)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        })
    }

}
