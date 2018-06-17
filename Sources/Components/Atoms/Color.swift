import UIKit

enum Color {
    case background
    case primary
    case secundary
}

extension Color {

    func uiColor() -> UIColor {
        switch self {

        case .background:
            return UIColor(red: 0.80, green: 0.90, blue: 0.96, alpha: 1.0)
        case .primary:
            return UIColor(red: 0.51, green: 0.82, blue: 0.78, alpha: 1.0)
        case .secundary:
            return UIColor(red: 0.45, green: 0.54, blue: 0.68, alpha: 1.0)
        }

    }
}
