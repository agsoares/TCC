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

        return accountServices.getUserData()
    }

    func getUserAccounts() -> Observable<[AccountSections]> {
        return accountServices.getAccountsData().map({
            [AccountSections(model: "Contas", items: $0.map({
                AccountCellItem(name: $0.name ?? "Conta", balance: $0.balance)
            }))]
        })
    }

    func getUserCards() -> Observable<[AccountSections]> {
        return accountServices.getCardsData().map({
            [AccountSections(model: "Cartões", items: $0.map({
                CardCellItem(name: $0.name ?? "Conta", owed: $0.owedValue, availableLimit: ($0.limit - $0.usedLimit))
            }))]
        })
    }

    func bind(
        viewDidAppear: Observable<Void>,
        reloadData: Observable<Void>,
        didSelectAccount: Observable<Int>,
        didSelectCard: Observable<Int>
    ) -> (
        isLoading: Observable<Bool>,
        userData: Observable<UserData>,
        userAccounts: Observable<[AccountSections]>,
        viewControllerEvents: Observable<Void>
    ) {

        let userData = Observable.merge(viewDidAppear, reloadData)
            .flatMapLatest({ [weak self] in self?.getUserData() ?? Observable.never() })

        let accounts = Observable.zip(self.getUserAccounts(), self.getUserCards())
            .map({ $0 + $1 })

        let userAccounts = Observable.merge(viewDidAppear, reloadData)
            .flatMapLatest({ accounts })

        let isLoading = Observable.merge(
            Observable.merge(viewDidAppear, reloadData).mapTo(true),
            Observable.zip(userData, userAccounts).mapTo(false)
        )

        return (
            isLoading: isLoading,
            userData: userData,
            userAccounts: userAccounts,
            viewControllerEvents: Observable<Void>.never()
        )
    }
}
