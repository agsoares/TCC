import UIKit
import RxSwift

extension UIView {

    @discardableResult
    func rounded(corners: CACornerMask? = nil, radius: CGFloat? = nil) -> Self {
        self.rx.observe(CGRect.self, "bounds")
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] bounds in
                self?.layer.cornerRadius = radius ?? ((bounds?.height ?? 0) / 2)
                if let corners = corners {
                    self?.layer.maskedCorners = corners
                    self?.layer.masksToBounds = true
                }
            })
            .disposed(by: rx.disposeBag)
        return self
    }

    @discardableResult
    func background(color: ColorAsset) -> Self {
        self.backgroundColor = color.color
        return self
    }

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}
