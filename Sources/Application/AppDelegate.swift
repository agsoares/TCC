import UIKit
import RxSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        self.setupNavigationBar()
        self.setupTabBar()

        let window  = UIWindow(frame: UIScreen.main.bounds)

        let initialViewController: UIViewController
        if let firebaseUser = Auth.auth().currentUser {
            initialViewController = AppRouter.home(user: firebaseUser)
        } else {
            initialViewController = AppRouter.auth()
        }

        window.rootViewController = initialViewController
        window.makeKeyAndVisible()

        self.window = window
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
