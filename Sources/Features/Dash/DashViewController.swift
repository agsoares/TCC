import UIKit
import RxSwift

class DashViewController: UIViewController {

    var disposeBag = DisposeBag()
    var viewModel: DashViewModel!


    init(viewModel: DashViewModel) {
        super.init(nibName: "DashViewController", bundle: Bundle.init(for: AuthViewController.self))
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

    }
}
