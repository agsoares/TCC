import UIKit
import RxSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

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
}
