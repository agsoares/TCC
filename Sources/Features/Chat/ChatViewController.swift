import UIKit
import RxSwift
import RxDataSources

class ChatViewController: UIViewController {

    var viewModel: ChatViewModel!

    private let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!

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
        viewModel.messageDataSource
            .debug()
            .bind(to: tableView.rx.items(cellIdentifier: ChatTableViewCell.identifier,
                                         cellType: ChatTableViewCell.self)) { _, model, cell in
                cell.configureCell(withMessage: model)
            }
            .disposed(by: self.disposeBag)
    }

    @objc private func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
