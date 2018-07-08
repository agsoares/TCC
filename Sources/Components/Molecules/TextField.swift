import UIKit
import RxSwift

class TextField: UITextField {

    var disposeBag = DisposeBag()

    struct Constants {
        static let defaultHeight: CGFloat = 50
    }

    init() {

        super.init(frame: CGRect.zero)
        self.backgroundColor = Color.backgroundAccent.uiColor()
        self.layer.borderColor = Color.borderColor.uiColor().cgColor
        self.layer.borderWidth = 2
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let padding = UIEdgeInsets(top: 0, left: Spacing.base, bottom: 0, right: Spacing.base)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

}

extension TextField {

    func rounded() -> TextField {
        self.clipsToBounds = true
        self.rx.methodInvoked(#selector(layoutSubviews))
            .bind(onNext: { [weak self] _ in

                self?.layer.cornerRadius = (self?.frame.height ?? 0) / 2.0
            })
            .disposed(by: self.disposeBag)
        return self
    }
}
