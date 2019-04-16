import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

struct Constants {
    static let maxHeader: CGFloat = 200
    static let minHeader: CGFloat = 20
}

class DashViewController: UIViewController {

    private var disposeBag = DisposeBag()
    private var viewModel: DashViewModel
    private var dataSource: RxTableViewSectionedReloadDataSource<DashViewModel.AccountSections>?

    private var isPanEnabled: Bool = false

    private var balanceLabel: Label = {
        return Label()
            .style(style: .r30)
            .color(Asset.Colors.lightText)
    }()

    private var tableViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.darkBackground.color
        return view
    }()

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Asset.Colors.darkBackground.color
        return tableView
    }()

    private var headerHeightConstraint: Constraint?

    //private var refreshControl: UIActivityIndicatorView!

    init(viewModel: DashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        setupViews()
        setupConstraints()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar()
    }

    @objc func reload() {

        self.viewModel.getUserData()
            .do(onSubscribe: { [weak self] in
                //self?.refreshControl.startAnimating()
                self?.balanceLabel.isHidden = true
            }, onDispose: { [weak self] in
                //self?.refreshControl.stopAnimating()
                self?.balanceLabel.isHidden = false
                self?.tableView.refreshControl?.endRefreshing()
            })
            .subscribe(onNext: { [weak self] (userData) in
                self?.balanceLabel.text = userData.balance.currency()
                self?.tableView.reloadData()
            }).disposed(by: self.disposeBag)
    }

    private func setupViews() {
        setupNavigationBar()

        view.backgroundColor = Asset.Colors.greenAccent.color

        view.addSubviews([balanceLabel, tableViewContainer])
        tableViewContainer.addSubviews([tableView])

        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = true

        tableView.rx
            .setDelegate(self)
            .disposed(by: self.disposeBag)

        tableView.panGestureRecognizer.addTarget(self, action: #selector(self.panTableView(_:)))


//        tableView.refreshControl = UIRefreshControl()
//        tableView.refreshControl?.tintColor = .clear
//        tableView.refreshControl?
//            .addTarget(self,
//                       action: #selector(self.reload),
//                       for: .valueChanged)
    }

    private func setupConstraints() {

        self.balanceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
        }

        self.tableViewContainer.snp.makeConstraints { make in
            self.headerHeightConstraint = make.top.equalTo(self.view.safeAreaLayoutGuide).offset(Constants.maxHeader).constraint
            make.left.bottom.right.equalTo(self.view.safeAreaLayoutGuide)
        }

        self.tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.bottom.right.equalToSuperview()
        }
    }

    @objc private func panTableView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.velocity(in: sender.view).y * 0.01

        guard let constant = headerHeightConstraint?.layoutConstraints.first?.constant else { return }
        let constraintSize = min(max(constant + translation, Constants.minHeader), Constants.maxHeader)

        let panUp   = translation < 0 && constraintSize > Constants.minHeader && tableView.contentOffset.y > 0
        let panDown = translation > 0 && constraintSize < Constants.maxHeader && tableView.contentOffset.y < 0

        if panUp || panDown {
            tableView.contentOffset = CGPoint.zero
        }

        if tableView.contentOffset.y == 0 {
            headerHeightConstraint?.update(offset: constraintSize)
        }

        let percentage = (constraintSize - Constants.minHeader) / (Constants.maxHeader - Constants.minHeader)
        updateHeader(percentage: percentage)
        if sender.state == .ended {
            snapHeader(percentage)
        }
    }

    private func updateHeader(percentage: CGFloat) {

    }

    private func snapHeader(_ percentage: CGFloat) {
        let constraintSize = percentage > 0.5 ? Constants.maxHeader : Constants.minHeader
        headerHeightConstraint?.update(offset: constraintSize)
        UIView.animate(withDuration: 0.3, animations: {
            self.updateHeader(percentage: percentage > 0.5 ? 1 : 0)
            self.view.layoutIfNeeded()
        })
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }

    private func bindViewModel() {

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

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        guard let constraintSize = headerHeightConstraint?.layoutConstraints.first?.constant else { return }

        let panUp   = constraintSize > Constants.minHeader && tableView.contentOffset.y >= 0
        let panDown = constraintSize < Constants.maxHeader && tableView.contentOffset.y <= 0
        guard panUp || panDown else { return }

        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        guard let constraintSize = headerHeightConstraint?.layoutConstraints.first?.constant else { return }
        let panUp   = velocity.y < 0 && constraintSize > Constants.minHeader && tableView.contentOffset.y > 0
        let panDown = velocity.y > 0 && constraintSize < Constants.maxHeader && tableView.contentOffset.y < 0

        guard panUp || panDown else { return }

        self.tableView.contentOffset = CGPoint.zero
        if abs(velocity.y) > 1.0 {
            snapHeader(velocity.y > 0 ? 0 : 1)
        } else {
            let percentage = (constraintSize - Constants.minHeader) / (Constants.maxHeader - Constants.minHeader)
            snapHeader(percentage)
        }
    }
}
