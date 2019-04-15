import UIKit
import RxSwift
import SnapKit
import Firebase

class AuthViewController: UIViewController {

    private let viewModel: AuthViewModel
    private var disposeBag = DisposeBag()

    private var emailTextField: TextField = {
        return TextField(frame: .zero)
            .placeholder("Email")
    }()

    private var passwordTextField: TextField = {
        return TextField(frame: .zero)
            .placeholder("Senha")
            .secure()
    }()

    private var signInButton: ActionButton = {
        return ActionButton(frame: .zero)
            .title("Entrar")
            .rounded()
            .green()
    }()

    private var signUpButton: ActionButton = {
        return ActionButton(frame: .zero)
            .title("Cadastrar")
            .rounded()
            .green()
            .text()
    }()

    private var bottomConstraint: Constraint?

    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        bindViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let bottomConstraint = self.bottomConstraint?.layoutConstraints.first {
            KeyboardObserver.addConstraint(bottomConstraint, noKeyboardConst: 20, keyboardConst: 8)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let bottomConstraint = self.bottomConstraint?.layoutConstraints.first {
            KeyboardObserver.removeConstraint(bottomConstraint)
        }
    }

    private func setupViews() {
        view.backgroundColor = Asset.Colors.darkBackground.color
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        passwordTextField.keyboardType = .default

        view.addSubviews([emailTextField, passwordTextField])
        view.addSubviews([signInButton, signUpButton])
    }

    private func setupConstraints() {

        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.centerY.equalToSuperview().dividedBy(1.5)
            make.left.equalTo(self.view).offset(24)
            make.right.equalTo(self.view)
        }

        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(self.emailTextField.snp.bottom).offset(10)
            make.left.equalTo(self.view).offset(24)
            make.right.equalTo(self.view)
        }

        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            self.bottomConstraint = make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20).constraint
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
        }

        signInButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.bottom.equalTo(signUpButton.snp.top).offset(-10)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
        }
    }

    private func bindViewModel() {
        let (
            isValid,
            userLoggedIn
        ) = viewModel.bind(
            email: emailTextField.rx.text.asObservable(),
            password: passwordTextField.rx.text.asObservable(),
            signInButton: signInButton.rx.tapWithThrottle.asObservable(),
            signUpButton: signUpButton.rx.tapWithThrottle.asObservable()
        )

        isValid
            .subscribe()
            .disposed(by: self.disposeBag)

        userLoggedIn
            .subscribe(onNext: { [weak self] event in
                switch event {

                case .next(let user):
                    let home = AppRouter.home(user: user)
                    home.modalTransitionStyle = .crossDissolve
                    self?.present(home, animated: true, completion: nil)

                case .error(let error):
                    self?.showError(message: error.localizedDescription)

                case .completed:
                    break
                }
            })
            .disposed(by: self.disposeBag)
    }
}
