import Foundation
import Firebase
import RxSwift
import RxDataSources

class DashViewModel {
    typealias AccountSections = SectionModel<String, CellItem>

    let accountServices = AccountServices()
    let accountsObservable: Observable<[AccountSections]>

    private let user: User?

    private let accountsSubject = BehaviorSubject<[AccountSections]>(value: [])

    init(user: User?) {
        self.user = user
        accountsObservable = accountsSubject.asObserver()
    }

    func getUserData() -> Observable<UserData> {
        accountsSubject.onNext([
            AccountSections(
                model: "Contas",
                items: [
                    AccountCellItem(name: "teste", balance: -100),
                    AccountCellItem(name: "teste2", balance: 100),
                    AccountCellItem(name: "teste3", balance: 0)
                ]
            ),
        ])

        return accountServices.getUserData()
    }

    func bind() {

    }
}
