import Foundation
import RxSwift
import RxDataSources

class DashViewModel {
    typealias AccountSections = SectionModel<String, String>

    let accountServices = AccountServices()
    let accountsObservable: Observable<[AccountSections]>

    private let accountsSubject = BehaviorSubject<[AccountSections]>(value: [])

    init() {

        accountsObservable = accountsSubject.asObserver()
    }

    func getUserData() -> Observable<UserData> {
        accountsSubject.onNext([
            AccountSections(model: "Contas", items: ["Teste", "Teste2", "Teste3","Teste", "Teste2", "Teste3","Teste", "Teste2", "Teste3","Teste", "Teste2", "Teste3","Teste", "Teste2", "Teste3", ]),
            AccountSections(model: "Cartões", items: ["Teste", "Teste2", "Teste3" ])
        ])

        return accountServices.getUserData()
    }
}
