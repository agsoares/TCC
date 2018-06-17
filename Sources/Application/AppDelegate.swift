import UIKit
import RxSwift
import Firebase

let globalState: Variable<GlobalState> = Variable(GlobalState())

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let initialViewController: UIViewController?

        if globalState.value.user == nil {
            initialViewController = AppRouter.loginViewController()
        } else {
            initialViewController = DashViewController()
        }
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()

        FirebaseApp.configure()
        return true
    }

}
