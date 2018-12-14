import UIKit
import RxSwift
import Firebase

class AuthViewController: UIViewController {

    struct Constants {
        static let nibName = "AuthViewController"
    }

    var disposeBag = DisposeBag()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    func bindViewModel() {
        let (
            isValid,
            userLoggedIn
        ) = authViewModel(
            email: emailTextField.rx.text.asObservable(),
            password: passwordTextField.rx.text.asObservable(),
            signInButton: signInButton.rx.tap.asObservable().throttle(0.5, scheduler: MainScheduler.instance),
            signUpButton: signUpButton.rx.tap.asObservable().throttle(0.5, scheduler: MainScheduler.instance)
        )

        isValid
            .debug()
            .subscribe()
            .disposed(by: self.disposeBag)

        userLoggedIn
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] user in
                let vc = AppRouter.home(user: user)
                self?.present(vc, animated: true, completion: nil)
            })
            .disposed(by: self.disposeBag)
    }
}
