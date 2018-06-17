import UIKit
import RxCocoa
import RxSwift

class AuthViewController: ViewController {
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

    var viewModel: AuthViewModel!

    init(viewModel: AuthViewModel) {
        super.init()
        self.viewModel = viewModel
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRx()

    }

    func setupViews() {
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

    func setupRx() {
    }
}
