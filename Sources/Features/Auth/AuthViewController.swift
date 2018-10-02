import UIKit
import RxSwift
import Firebase

class AuthViewController: UIViewController {

    var disposeBag = DisposeBag()
    var viewModel: AuthViewModel!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    init(viewModel: AuthViewModel) {
        super.init(nibName: "AuthViewController", bundle: Bundle.init(for: AuthViewController.self))
        self.viewModel = viewModel
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }

    func setupRx() {

        let credentials = Observable.combineLatest(emailTextField.rx.text, passwordTextField.rx.text)

        signInButton.rx.tap
            .withLatestFrom(credentials)
            .flatMapLatest({ [weak self] (email, pass) -> Observable<User>  in
                guard let `self` = self else { return Observable.empty() }
                return self.viewModel.signIn(withEmail: email, andPassword: pass)
            })
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] user in
                let vc = AppRouter.home(user: user)
                self?.present(vc, animated: true, completion: nil)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: self.disposeBag)

        signUpButton.rx.tap
            .withLatestFrom(credentials)
            .flatMapLatest({ [weak self] (email, pass) -> Observable<User>  in
                guard let `self` = self else { return Observable.empty() }
                return self.viewModel.signUp(withEmail: email, andPassword: pass)
            })
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] user in
                let vc = AppRouter.home(user: user)
                self?.present(vc, animated: true, completion: nil)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: self.disposeBag)
    }
}
