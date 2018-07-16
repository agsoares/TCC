import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct SectionOfCollectionViews {
    var header: String
    var items: [Item]
}

extension SectionOfCollectionViews: SectionModelType {
    typealias Item = TableViewCollectionViewModel

    init(original: SectionOfCollectionViews, items: [Item]) {
        self = original
        self.items = items
    }
}

class DashViewModel: ViewModel {
    typealias Section = SectionOfCollectionViews

    let sections: BehaviorRelay<[Section]> = BehaviorRelay<[Section]>(value: [])

    override init() {
        super.init()
    }
}
