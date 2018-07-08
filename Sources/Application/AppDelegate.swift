import UIKit
import RxSwift
import Firebase

let globalState: Variable<GlobalState> = Variable(GlobalState())

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        window = UIWindow(frame: UIScreen.main.bounds)
        let initialViewController: UIViewController?

        // TODO: change to authentication flow
        Auth.auth().signInAnonymously { (_, _) in

        }
        if globalState.value.user == nil {
            initialViewController = AppRouter.loginViewController()
        } else {
            initialViewController = DashViewController()
        }
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()

        return true
    }
}
