import UIKit
import RxSwift
import Firebase

class AuthViewController: UIViewController {

    private let viewModel: AuthViewModel

    var disposeBag = DisposeBag()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    func bindViewModel() {
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
