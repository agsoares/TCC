import Foundation
import RxSwift

protocol ChatViewModel {

    var messageDataSource: Observable<[MessageData]> { get set }
}
