import UIKit
import RxSwift
import RxDataSources

class DashViewController: UIViewController {

    struct Constants {
        static let headerHeight: CGFloat = 300
    }

    var disposeBag = DisposeBag()
    var viewModel: DashViewModel!

    var headerConstraint: NSLayoutConstraint?

    @IBOutlet weak var tableView: UITableView!

    init(viewModel: DashViewModel) {
        super.init(nibName: "DashViewController", bundle: Bundle.init(for: AuthViewController.self))
        self.viewModel = viewModel
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self

        setupViews()
        setupRx()
    }

    func setupViews() {

    }

    func setupRx() {

    }
}

extension DashViewController: UITableViewDelegate {
}

extension DashViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
