import UIKit
import ReactorKit

class AuthViewController: ViewController, View {
    typealias Reactor = AuthReactor

    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.blue
    }

    func bind(reactor: AuthReactor) {

    }
    
}
