import Foundation
import RxSwift
import RxCocoa

class DashViewModel {

    let accountServices = AccountServices()

    func getUserData() -> Observable<UserData> {

        return accountServices.getUserData()
    }
}
