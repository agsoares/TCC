import UIKit
import RxSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        let window  = UIWindow(frame: UIScreen.main.bounds)

        let initialViewController: UIViewController
        if let user = Auth.auth().currentUser {
            initialViewController = AppRouter.auth()
        } else {
            initialViewController = AppRouter.auth()
        }

        window.rootViewController = initialViewController
        window.makeKeyAndVisible()

        self.window = window
        return true
    }
}
