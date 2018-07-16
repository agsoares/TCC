import UIKit
import RxSwift
import RxDataSources

class DashViewController: ViewController {

    let tableView: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()

    let dataSource: RxTableViewSectionedReloadDataSource<DashViewModel.Section>
    var viewModel: DashViewModel

    init(viewModel: DashViewModel) {
        self.tableView.register(TableViewCollectionViewCell.self,
                                forCellReuseIdentifier: TableViewCollectionViewCell.identifier)

        self.dataSource = RxTableViewSectionedReloadDataSource<DashViewModel.Section>(configureCell: { (_, tv, ip, item) in
            let cell = tv.dequeueReusableCell(withIdentifier: TableViewCollectionViewCell.identifier,
                                              for: ip)
            cell.textLabel?.text = "\(item)"

            return cell
        })
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupRx()
    }

    func setupViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupRx() {

        viewModel.sections.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
