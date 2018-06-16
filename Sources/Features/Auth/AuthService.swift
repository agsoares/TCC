import Foundation
import RxSwift
import Result
import FirebaseAuth

class AuthService {

    class func sendVerification(toEmail email: String) -> Observable<Void> {
        return Observable.create({ (observer) -> Disposable in

            let actionCodeSettings = ActionCodeSettings()
            actionCodeSettings.url = URL(string: "")
            actionCodeSettings.handleCodeInApp = true
            actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier ?? "")

            Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    observer.onError(error)
                } else {
                    observer.onNext(())
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        })
    }
    
}
