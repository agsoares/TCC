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

        tableView.register(UINib(nibName: ChatTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: ChatTableViewCell.identifier)
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
}
