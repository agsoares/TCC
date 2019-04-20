import UIKit
import RxSwift
import RxDataSources

class ChatViewController: UIViewController {

    private let viewModel: ChatViewModel

    private var tableViewContainer: UIView = {
        return UIView()
            .rounded(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 16)
            .background(color: Asset.Colors.mediumBackground)
    }()

    private var tableView: UITableView = {
        let tableView = UITableView()
            .background(color: Asset.Colors.mediumBackground)

        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = true
        tableView.allowsSelection = false

        tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.identifier)
        return tableView
    }()

    private var textFieldContainer: UIView = {
        return UIView()
            .background(color: Asset.Colors.darkBackground)
    }()

    private var messageTextField: TextField = {
        return TextField(frame: .zero)
    }()

    private var sendMessageButton: ActionButton = {
        return ActionButton(frame: .zero)
            .title("")
            .rounded()
            .green()
    }()

    init(viewModel: ChatViewModel) {
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

    private func setupViews() {
        view.backgroundColor = .clear

        view.addSubviews([tableViewContainer, textFieldContainer])
        tableViewContainer.addSubviews([tableView])
        textFieldContainer.addSubviews([messageTextField, sendMessageButton])
    }

    private func setupConstraints() {

        tableViewContainer.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(8)
            make.left.right.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(textFieldContainer.snp.bottom)
        }

        textFieldContainer.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.bottom.right.equalTo(self.view.safeAreaLayoutGuide)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.bottom.right.equalToSuperview()
        }

        messageTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.right.equalTo(sendMessageButton.snp.left).inset(8)
            make.centerY.equalToSuperview()
            make.height.equalTo(44)
        }

        sendMessageButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(40)
        }
    }

    private func bindViewModel() {

        let (
            messagesDatasource,
            viewControllerEvents
        ) = viewModel.bind(
            didSendMessage: Observable.never()
        )

        let datasource = RxTableViewSectionedReloadDataSource<ChatViewModel.MessageSection>(configureCell: {
            (_, tableView, indexPath, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
            (cell as? ConfigurableTableViewCell)?.configure(withItem: item)
            return cell
        })

        messagesDatasource
            .bind(to: tableView.rx.items(dataSource: datasource))
            .disposed(by: rx.disposeBag)

        viewControllerEvents
            .subscribe()
            .disposed(by: rx.disposeBag)
    }

    @objc private func close() {

        self.dismiss(animated: true, completion: nil)
    }
}
