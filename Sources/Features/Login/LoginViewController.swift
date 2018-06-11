import UIKit
import ReactorKit

class LoginViewController: ViewController, View {
    typealias Reactor = LoginReactor

    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.blue
    }

    func bind(reactor: LoginReactor) {

    }
}
