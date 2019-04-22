import UIKit
import RxSwift
import RxDataSources
import SnapKit

private struct Constants {
    static let maxTop: CGFloat = 160
    static let minTop: CGFloat = 8

    static let textFieldContainerHeight: CGFloat = 50
}

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
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Constants.textFieldContainerHeight, right: 0)

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
            .image(Asset.Assets.send.image)
            .tint(Asset.Colors.lightText)
    }()

    private var bottomConstraint: Constraint?
    private var topConstraint: Constraint?

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let bottomConstraint = self.bottomConstraint?.layoutConstraints.first {
            KeyboardObserver.addConstraint(bottomConstraint, noKeyboardConst: 0)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let bottomConstraint = self.bottomConstraint?.layoutConstraints.first {
            KeyboardObserver.removeConstraint(bottomConstraint)
        }
    }

    private func setupViews() {
        view.backgroundColor = .clear

        messageTextField.autocapitalizationType = .none
        messageTextField.autocorrectionType = .no

        view.addSubviews([tableViewContainer, textFieldContainer])
        tableViewContainer.addSubviews([tableView])
        textFieldContainer.addSubviews([messageTextField, sendMessageButton])

        tableView.panGestureRecognizer.addTarget(self, action: #selector(self.panTableView(_:)))
    }

    private func setupConstraints() {

        tableViewContainer.snp.makeConstraints { make in
            self.topConstraint = make.top.equalTo(self.view.safeAreaLayoutGuide).inset(Constants.minTop).constraint
            make.left.right.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(textFieldContainer.snp.bottom)
        }

        textFieldContainer.snp.makeConstraints { make in
            make.height.equalTo(Constants.textFieldContainerHeight)
            make.left.right.equalTo(self.view.safeAreaLayoutGuide)
            self.bottomConstraint = make.bottom.equalTo(self.view.safeAreaLayoutGuide).constraint
        }

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
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

    @objc private func panTableView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.velocity(in: sender.view).y * 0.01

        guard let constant = topConstraint?.layoutConstraints.first?.constant else { return }
        let constraintSize = max(constant + translation, Constants.minTop)

        print("\(translation) = \(tableView.contentOffset.y)")

        let panUp   = translation < 0 && constraintSize > Constants.minTop && tableView.contentOffset.y > 0
        let panDown = translation > 0 && tableView.contentOffset.y < 0

        if panUp || panDown {
            tableView.contentOffset = CGPoint.zero
        }

        if tableView.contentOffset.y == 0 {
            topConstraint?.update(offset: constraintSize)
        }

        if constraintSize > Constants.maxTop * 1.5 { close() }
        if sender.state == .ended {
            if constraintSize > Constants.maxTop {
                close()
            } else {
                snapHeader()
            }
        }
    }

    private func snapHeader() {
        topConstraint?.update(offset: Constants.minTop)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }

    private func bindViewModel() {

        let didChangeText = messageTextField.rx.text.asObservable()

        let didSendMessage = sendMessageButton.rx.tapWithThrottle
            .withLatestFrom(messageTextField.rx.text)

        let (
            messagesDatasource,
            shouldShowTextField,
            textFieldValue,
            viewControllerEvents
        ) = viewModel.bind(
            didChangeText: didChangeText,
            didSendMessage: didSendMessage
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

        shouldShowTextField
            .observeOn(MainScheduler.asyncInstance)
            .map({ !$0 })
            .bind(to: textFieldContainer.rx.isHidden)
            .disposed(by: rx.disposeBag)

        textFieldValue
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: messageTextField.rx.text)
            .disposed(by: rx.disposeBag)

        viewControllerEvents
            .subscribe()
            .disposed(by: rx.disposeBag)
    }

    @objc private func close() {

        self.dismiss(animated: true, completion: nil)
    }
}
