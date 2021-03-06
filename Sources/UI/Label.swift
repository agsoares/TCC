import UIKit

enum FontStyle {
    case r14
    case r16
    case r30
    case b16
    case b30

    var font: Font {
        switch self {
        case .r14: return FontFamily.OpenSans.regular.font(size: 14)
        case .r16: return FontFamily.OpenSans.regular.font(size: 16)
        case .r30: return FontFamily.OpenSans.regular.font(size: 30)
        case .b16: return FontFamily.OpenSans.bold.font(size: 16)
        case .b30: return FontFamily.OpenSans.bold.font(size: 30)
        }
    }
}

class Label: UILabel {

    @discardableResult
    func style(style: FontStyle) -> Self {
        self.numberOfLines = 0
        self.font = style.font
        return self
    }

    @discardableResult
    func color(_ color: ColorAsset) -> Self {
        self.textColor = color.color
        return self
    }

    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
}
