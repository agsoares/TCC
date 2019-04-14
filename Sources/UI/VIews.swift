import UIKit
import RxSwift

extension UIView {

    @discardableResult
    func rounded() -> Self {
        self.rx.observe(CGRect.self, "bounds")
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] bounds in
                self?.layer.cornerRadius = (bounds?.height ?? 0) / 2
            })
            .disposed(by: rx.disposeBag)
        return self
    }

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}
