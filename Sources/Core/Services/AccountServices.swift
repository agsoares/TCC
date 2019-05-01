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

    func getAccountsData() -> Observable<[AccountData]> {

        guard let currentUser = Auth.auth().currentUser else { return Observable.error(ApiError.noUser) }
        return Observable.create({ (observer) in

            let accountsRef = self.db.collection("users/\(currentUser.uid)/accounts")
            accountsRef.getDocuments(completion: { (snapshot, error) in
                if let error = error { observer.onError(error) }
                guard let documents = snapshot?.documents else {
                    observer.onError(ApiError.genericError)
                    return
                }
                let accounts: [AccountData] = documents.compactMap({ AccountData(snapshot: $0) })
                observer.onNext(accounts)
                observer.onCompleted()
            })

            return Disposables.create()
        })
    }

    func getTransactions(forAccountId accountId: String) -> Observable<[TransactionData]> {

        guard let currentUser = Auth.auth().currentUser else { return Observable.error(ApiError.noUser) }
        return Observable.create({ (observer) in

            let transactionsRef = self.db.collection("users/\(currentUser.uid)/accounts/\(accountId)/transactions")
            transactionsRef.getDocuments(completion: { (snapshot, error) in
                if let error = error { observer.onError(error) }
                guard let documents = snapshot?.documents else {
                    observer.onError(ApiError.genericError)
                    return
                }
                let transactions: [TransactionData] = documents.compactMap({ TransactionData(snapshot: $0) })
                observer.onNext(transactions)
                observer.onCompleted()
            })

            return Disposables.create()
        })
    }

    func getCardsData() -> Observable<[CardData]> {

        guard let currentUser = Auth.auth().currentUser else { return Observable.error(ApiError.noUser) }
        return Observable.create({ (observer) in

            let cardsRef = self.db.collection("users/\(currentUser.uid)/cards")
            cardsRef.getDocuments(completion: { (snapshot, error) in
                if let error = error { observer.onError(error) }
                guard let documents = snapshot?.documents else {
                    observer.onError(ApiError.genericError)
                    return
                }
                let cards: [CardData] = documents.compactMap({ CardData(snapshot: $0) })
                observer.onNext(cards)
                observer.onCompleted()
            })

            return Disposables.create()
        })
    }

    func getStatements(forCardId cardId: String) -> Observable<[StatementData]> {

        guard let currentUser = Auth.auth().currentUser else { return Observable.error(ApiError.noUser) }
        return Observable.create({ (observer) in

            let statementsRef = self.db.collection("users/\(currentUser.uid)/cards/\(cardId)/statements")
            statementsRef.getDocuments(completion: { (snapshot, error) in
                if let error = error { observer.onError(error) }
                guard let documents = snapshot?.documents else {
                    observer.onError(ApiError.genericError)
                    return
                }
                let statements: [StatementData] = documents.compactMap({ StatementData(snapshot: $0) })
                observer.onNext(statements)
                observer.onCompleted()
            })

            return Disposables.create()
        })
    }

    func getTransactions(forStatementId statementId: String, andCardId cardId: String) -> Observable<[TransactionData]> {

        guard let currentUser = Auth.auth().currentUser else { return Observable.error(ApiError.noUser) }
        return Observable.create({ (observer) in

            let transactionsRef = self.db.collection("users/\(currentUser.uid)/cards/\(cardId)/statements/\(statementId)/transactions")
            transactionsRef.getDocuments(completion: { (snapshot, error) in
                if let error = error { observer.onError(error) }
                guard let documents = snapshot?.documents else {
                    observer.onError(ApiError.genericError)
                    return
                }
                let transactions: [TransactionData] = documents.compactMap({ TransactionData(snapshot: $0) })
                observer.onNext(transactions)
                observer.onCompleted()
            })

            return Disposables.create()
        })
    }
}
