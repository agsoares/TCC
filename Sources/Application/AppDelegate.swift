import UIKit
import RxSwift
import Firebase

// All hope abandon, ye who enter here! ~ Dante Alighieri

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        self.setupNavigationBar()
        self.setupTabBar()

        let initialVC: UIViewController
        if let firebaseUser = Auth.auth().currentUser {
            initialVC = AppRouter.home(user: firebaseUser)
        } else {
            initialVC = AppRouter.auth()
        }

        window?.rootViewController = initialVC
        window?.makeKeyAndVisible()

        return true
    }

    private func setupNavigationBar() {
        UINavigationBar.appearance().barTintColor = Asset.Colors.mediumBackground.color
        UINavigationBar.appearance().tintColor = Asset.Colors.greenAccent.color
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().isTranslucent = false
    }

    private func setupTabBar() {
        UITabBar.appearance().barTintColor = Asset.Colors.mediumBackground.color
        UITabBar.appearance().tintColor = Asset.Colors.greenAccent.color
        UITabBar.appearance().isTranslucent = false
    }
}
