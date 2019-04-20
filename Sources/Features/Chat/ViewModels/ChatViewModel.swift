import Foundation
import RxSwift
import RxDataSources

protocol ChatViewModel {
    typealias MessageSection = SectionModel<String, CellItem>

    func bind(
        didSendMessage: Observable<String?>
    ) -> (
        messagesDatasource: Observable<[MessageSection]>,
        viewControllerEvents: Observable<Void>
    )
}
