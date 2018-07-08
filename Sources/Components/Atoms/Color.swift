import UIKit

enum Color {
    case background
    case backgroundAccent
    case borderColor
    case primary
    case secundary
}

extension Color {

    func uiColor() -> UIColor {
        switch self {

        case .background:
            return UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        case .backgroundAccent:
            return UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1.00)
        case .borderColor:
            return UIColor(red: 0.90, green: 0.93, blue: 0.94, alpha: 1.00)
        case .primary:
            return UIColor(red: 0.51, green: 0.82, blue: 0.78, alpha: 1.0)
        case .secundary:
            return UIColor(red: 0.45, green: 0.54, blue: 0.68, alpha: 1.0)
        }
    }
}
