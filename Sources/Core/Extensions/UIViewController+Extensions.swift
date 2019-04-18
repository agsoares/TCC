import UIKit

extension UIViewController {

    func addTapToDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapToDismiss))
        self.view.addGestureRecognizer(tapGesture)
    }

    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? UIViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController?.topMostViewController() ?? UIViewController()
    }

    @objc private func tapToDismiss() {
        self.view.endEditing(true)
    }
}
