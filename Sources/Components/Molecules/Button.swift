import UIKit
import RxSwift
import RxCocoa

class Button: UIButton {

    var disposeBag = DisposeBag()
}

extension Button {

    struct Constants {
        static let defaultHeight: CGFloat = 50
    }

    func primaryStyle() -> Button {
        self.backgroundColor = Color.primary.uiColor()
        return self
    }

    func rounded() -> Button {
        self.clipsToBounds = true
        self.rx.methodInvoked(#selector(layoutSubviews))
            .bind(onNext: { [weak self] _ in

                self?.layer.cornerRadius = (self?.frame.height ?? 0) / 2.0
            })
            .disposed(by: self.disposeBag)
        return self
    }
}
