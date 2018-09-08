import UIKit
import RxSwift

class AuthViewController: UIViewController {

    var disposeBag = DisposeBag()
    var viewModel: AuthViewModel!

    @IBOutlet weak var sendEmailButton: UIButton!

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

        self.sendEmailButton
            .rx.tap
            .flatMap(self.viewModel.signIn)
            .asObservable()
            .subscribe(onNext: { [weak self] (_) in

                DispatchQueue.main.async {

                    self?.present(AppRouter.auth(), animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }
}
