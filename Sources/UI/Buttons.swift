import UIKit
import RxSwift

class ActionButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = FontFamily.OpenSans.bold.font(size: 14)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult
    func title(_ title: String?) -> Self {
        setTitle(title, for: .normal)
        return self
    }

    @discardableResult
    func green() -> Self {
        setTitleColor(Asset.Colors.lightText.color, for: .normal)
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0
        backgroundColor = Asset.Colors.greenAccent.color
        return self
    }

    @discardableResult
    func red() -> Self {
        setTitleColor(Asset.Colors.lightText.color, for: .normal)
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0
        backgroundColor = Asset.Colors.redAccent.color
        return self
    }

    @discardableResult
    func dark() -> Self {
        setTitleColor(Asset.Colors.mediumText.color, for: .normal)
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0
        backgroundColor = Asset.Colors.mediumBackground.color
        return self
    }

    @discardableResult
    func outline() -> Self {
        setTitleColor(backgroundColor, for: .normal)
        layer.borderColor = backgroundColor?.cgColor
        layer.borderWidth = 2
        backgroundColor = .clear
        return self
    }

    @discardableResult
    func text() -> Self {
        setTitleColor(backgroundColor, for: .normal)
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0
        backgroundColor = .clear
        return self
    }

    @discardableResult
    func tint(_ color: ColorAsset) -> Self {
        self.tintColor = color.color
        return self
    }

    @discardableResult
    func image(_ image: UIImage) -> Self {
        contentMode = .scaleAspectFit
        setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        return self
    }
}
