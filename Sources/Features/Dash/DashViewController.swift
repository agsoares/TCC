import UIKit
import RxSwift
import RxDataSources

class DashViewController: UIViewController {

    struct Constants {
        static let nibName = "DashViewController"
        static let headerHeight: CGFloat = 200
    }

    var disposeBag = DisposeBag()
    var viewModel: DashViewModel
    var dataSource: RxTableViewSectionedReloadDataSource<DashViewModel.AccountSections>?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var refreshControl: UIActivityIndicatorView!

    init(viewModel: DashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        setupViews()
        bindViewModel()
        setupRx()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reload()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupNavigationBar()
    }

    @objc func reload() {

        self.viewModel.getUserData()
            .do(onSubscribe: { [weak self] in
                self?.refreshControl.startAnimating()
                self?.balanceLabel.isHidden = true
            }, onDispose: { [weak self] in
                self?.refreshControl.stopAnimating()
                self?.balanceLabel.isHidden = false
                self?.tableView.refreshControl?.endRefreshing()
            })
            .subscribe(onNext: { [weak self] (userData) in
                self?.balanceLabel.text = userData.balance.currency()
                self?.tableView.reloadData()
            }).disposed(by: self.disposeBag)
    }

    private func setupViews() {
        self.tableView.contentInset.top = Constants.headerHeight
        self.tableView.contentOffset.y = -Constants.headerHeight
        self.setupNavigationBar()

        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.tintColor = .clear
        self.tableView.refreshControl?
            .addTarget(self,
                       action: #selector(self.reload),
                       for: .valueChanged)
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }

    private func bindViewModel() {

    }

    private func setupRx() {
        let dataSource = RxTableViewSectionedReloadDataSource<DashViewModel.AccountSections> (configureCell: {
            (_, tableView, indexPath, model) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

            cell.contentView.backgroundColor = Asset.Colors.darkBackground.color
            cell.textLabel?.text = model
            cell.textLabel?.textColor = UIColor.white
            cell.selectionStyle = .none

            return cell
        })

        self.dataSource = dataSource

        viewModel.accountsObservable
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
}

extension DashViewController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerHeightConstraint.constant = scrollView.contentOffset.y
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "Cell")

        header?.contentView.backgroundColor = Asset.Colors.secundary.color
        header?.textLabel?.text = self.dataSource?.sectionModels[section].model
        header?.textLabel?.textColor = Asset.Colors.grey.color

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
