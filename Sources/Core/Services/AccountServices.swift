import Foundation
import Firebase
import ObjectMapper
import RxSwift

class AccountServices {

    enum ApiError: Error {
        case noUser
        case genericError
    }

    let db = Firestore.firestore()

    init() {
        let settings = db.settings
        db.settings = settings
    }

    func getUserData() -> Observable<UserData> {

        guard let currentUser = Auth.auth().currentUser else { return Observable.error(ApiError.noUser) }
        return Observable.create({ (observer) in

            let userRef = self.db.document("users/\(currentUser.uid)")
            userRef.getDocument(completion: { (snapshot, error) in
                if let error = error { observer.onError(error) }
                guard
                   let data = snapshot?.data(),
                   let userData = UserData(JSON: data)
                else {
                    observer.onError(ApiError.genericError)
                    return
                }
                observer.onNext(userData)
                observer.onCompleted()
            })

            return Disposables.create()
        })
    }

    func getAccountsData() -> Observable<[AccountsData]> {

        guard let currentUser = Auth.auth().currentUser else { return Observable.error(ApiError.noUser) }
        return Observable.create({ (observer) in

            let accountsRef = self.db.collection("users/\(currentUser.uid)/accounts")
            accountsRef.getDocuments(completion: { (snapshot, error) in
                if let error = error { observer.onError(error) }
                guard let documents = snapshot?.documents else {
                    observer.onError(ApiError.genericError)
                    return
                }
                let accounts: [AccountsData] = documents.compactMap({ AccountsData(snapshot: $0) })
                observer.onNext(accounts)
                observer.onCompleted()
            })

            return Disposables.create()
        })
    }

}
