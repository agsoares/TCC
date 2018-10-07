import UIKit
import RxSwift
import RxDataSources

class DashViewController: UIViewController {

    struct Constants {
        static let nibName = "DashViewController"
        static let headerHeight: CGFloat = 200
    }

    var disposeBag = DisposeBag()
    var viewModel: DashViewModel!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!

    init(viewModel: DashViewModel) {
        super.init(nibName: Constants.nibName, bundle: Bundle.init(for: DashViewController.self))
        self.viewModel = viewModel
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        setupViews()
        setupRx()
    }

    func setupViews() {
        self.tableView.contentInset.top = Constants.headerHeight

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }

    func setupRx() {
        Observable.just(["Teste", "Teste"])
            .bind(to: tableView.rx.items(cellIdentifier: "Cell",
                                         cellType: UITableViewCell.self)) { _, model, cell in
                cell.textLabel?.text = model
            }
            .disposed(by: self.disposeBag)
    }
}

extension DashViewController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerHeightConstraint.constant = scrollView.contentOffset.y
    }
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
