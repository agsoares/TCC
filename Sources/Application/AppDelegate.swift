import UIKit
import RxSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()
    let router = AppCoordinator().anyRouter

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.setupNavigationBar()
        self.setupTabBar()

        router.setRoot(for: window ?? UIWindow())

        return true
    }

    private func setupNavigationBar() {
        UINavigationBar.appearance().barTintColor = Asset.Colors.secundary.color
        UINavigationBar.appearance().tintColor = Asset.Colors.primary.color
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().isTranslucent = false
    }

    private func setupTabBar() {
        UITabBar.appearance().barTintColor = Asset.Colors.secundary.color
        UITabBar.appearance().tintColor = Asset.Colors.primary.color
        UITabBar.appearance().isTranslucent = false
    }
}
