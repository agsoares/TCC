import UIKit
import RxSwift
import RxDataSources

class ChatViewController: UIViewController {

    private let viewModel: ChatViewModel
    private let disposeBag = DisposeBag()

    @IBOutlet private weak var tableView: UITableView!

    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRx()
        self.setupViews()

        tableView.register(UINib(nibName: ChatTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: ChatTableViewCell.identifier)

    }

    private func setupViews() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.close))
        self.navigationItem.leftBarButtonItem = closeButton
    }

    private func setupRx() {
        let dataSource = RxTableViewSectionedReloadDataSource<ChatViewModel.MessageSection>(configureCell: {
            (_, tableView, indexPath, item) -> UITableViewCell in

            let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath) as? Cell
            cell?.configure(withItem: item)
            return (cell as? UITableViewCell) ?? UITableViewCell()
        })

        viewModel.messageDataSource
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }

    @objc private func close() {

        self.dismiss(animated: true, completion: nil)
    }
}
