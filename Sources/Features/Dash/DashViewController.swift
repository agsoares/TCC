import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import RxDataSources
import SnapKit

private struct Constants {
    static let maxHeader: CGFloat = 200
    static let minHeader: CGFloat = 20
}

class DashViewController: UIViewController {

    private let viewModel: DashViewModel
    private let reloadPublish = PublishSubject<Void>()

    private var balanceLabel: Label = {
        return Label()
            .style(style: .r30)
            .color(Asset.Colors.lightText)
    }()

    private var tableViewContainer: UIView = {
        return UIView()
            .rounded(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 16)
            .background(color: Asset.Colors.darkBackground)
    }()

    private var tableView: UITableView = {
        let tableView = UITableView()
            .background(color: Asset.Colors.darkBackground)

        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = true

        return tableView
    }()

    private var refreshControl: UIActivityIndicatorView = {
        let refreshControl = UIActivityIndicatorView()

        return refreshControl
    }()

    private var headerHeightConstraint: Constraint?

    init(viewModel: DashViewModel) {
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar()
    }

    private func setupViews() {
        tableView.register(AccountCell.self, forCellReuseIdentifier: AccountCell.identifier)

        view.backgroundColor = Asset.Colors.greenAccent.color

        view.addSubviews([refreshControl, balanceLabel, tableViewContainer])
        tableViewContainer.addSubviews([tableView])

        tableView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)

        tableView.panGestureRecognizer.addTarget(self, action: #selector(self.panTableView(_:)))

        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = Asset.Colors.greenAccent.color
        tableView.refreshControl?.addTarget(
            self,
            action: #selector(self.reload),
            for: .valueChanged
        )
    }

    private func setupConstraints() {

        refreshControl.snp.makeConstraints { make in
            make.center.equalTo(balanceLabel)
        }

        balanceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }

        tableViewContainer.snp.makeConstraints { make in
            self.headerHeightConstraint = make.top.equalTo(self.view.safeAreaLayoutGuide).inset(Constants.maxHeader).constraint
            make.left.bottom.right.equalTo(self.view.safeAreaLayoutGuide)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
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

    private func bindViewModel() {

        let viewDidAppear = rx.methodInvoked(#selector(viewDidAppear(_:))).mapTo(())

        let reloadData = reloadPublish.asObserver()

        let didSelectAccount = tableView.rx.itemSelected
            .asObservable()
            .filter({ $0.section == 0 })
            .map({ $0.row })

        let didSelectCard = tableView.rx.itemSelected
            .asObservable()
            .filter({ $0.section == 1 })
            .map({ $0.row })

        let (
            isLoading,
            userData,
            userAccounts,
            viewControllerEvents
        ) = viewModel.bind(
            viewDidAppear: viewDidAppear,
            reloadData: reloadData,
            didSelectAccount: didSelectAccount,
            didSelectCard: didSelectCard
        )

        let dataSource = RxTableViewSectionedReloadDataSource<DashViewModel.AccountSections> (configureCell: {
            (_, tableView, indexPath, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
            (cell as? ConfigurableTableViewCell)?.configure(withItem: item)
            return cell
        })

        isLoading
            .observeOn(MainScheduler.asyncInstance)
            .do(onNext: { [weak self] isLoading in
                self?.balanceLabel.isHidden = isLoading
                self?.tableView.refreshControl?.endRefreshing()
            })
            .bind(to: self.refreshControl.rx.isAnimating)
            .disposed(by: rx.disposeBag)

        userData
            .observeOn(MainScheduler.asyncInstance)
            .do(onNext: { [weak self] _ in self?.balanceLabel.isHidden = false  })
            .map({ $0.balance.currency() })
            .bind(to: self.balanceLabel.rx.text)
            .disposed(by: rx.disposeBag)

        userAccounts
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)

        viewControllerEvents
            .observeOn(MainScheduler.asyncInstance)
            .subscribe()
            .disposed(by: rx.disposeBag)
    }

    @objc private func reload() {
        self.reloadPublish.onNext(())
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
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
