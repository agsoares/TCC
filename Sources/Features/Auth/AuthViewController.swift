import UIKit
import RxCocoa
import RxSwift
import Firebase

class AuthViewController: ViewController {
    let emailTextField: TextField = {
        let v = TextField().rounded()
        v.keyboardType = .emailAddress
        v.autocapitalizationType = .none
        v.autocorrectionType = .no
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let sendEmailButton: Button = {
        let button = Button()
        button.titleLabel?.text = "Entrar"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.red
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
        self.setupViews()
        self.setupRx()
    }

    func setupViews() {
        view.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: TextField.Constants.defaultHeight),
            emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.view.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: Spacing.base),
            emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Spacing.base)
        ])

        view.addSubview(sendEmailButton)
        NSLayoutConstraint.activate([
            sendEmailButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            sendEmailButton.heightAnchor.constraint(equalToConstant: Button.Constants.defaultHeight),
            sendEmailButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            sendEmailButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor)
        ])
    }

    func setupRx() {

        self.sendEmailButton
            .rx.tap
            .flatMap(self.viewModel.signIn)
            .asObservable()
            .subscribe(onNext: { [weak self] (_) in

                DispatchQueue.main.async {

                    self?.present(AppRouter.home(), animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }
}
