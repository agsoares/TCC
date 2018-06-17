import UIKit
import RxCocoa
import RxSwift
import ReactorKit

class AuthViewController: ViewController, View {
    typealias Reactor = AuthReactor

    let emailTextField: TextField = {
        let v = TextField()
        v.keyboardType = .emailAddress
        v.autocapitalizationType = .none
        v.autocorrectionType = .no
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let sendEmailButton: Button = {
        let button = Button()
            .round()
            .primaryStyle()
        button.titleLabel?.text = "Entrar"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])

        view.addSubview(sendEmailButton)
        NSLayoutConstraint.activate([
            sendEmailButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            sendEmailButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            sendEmailButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor)
        ])
    }

    func bind(reactor: AuthReactor) {
        sendEmailButton.rx.tap
            .map({ [weak self] in Reactor.Action.signIn(email: self?.emailTextField.text ?? "") })
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state.subscribe(onNext: { _ in

        })
        .disposed(by: disposeBag)
    }

}
