import Foundation
import RxSwift
import RxDataSources

protocol ChatViewModel {
    typealias MessageSection = SectionModel<String, CellItem>

    var messageDataSource: Observable<[MessageSection]> { get set }
}
