import UIKit
import SnapKit

class MessageCell: UITableViewCell {

    private var messageView: UIView = {
        return UIView()
            .rounded(radius: 16)
            .background(color: Asset.Colors.greenAccent)
    }()

    private var messageLabel: Label = {
        return Label()
            .style(style: .r16)
            .color(Asset.Colors.lightText)
    }()

    private var rightConstraint: Constraint?
    private var leftConstraint: Constraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        messageView.addSubviews([messageLabel])
        contentView.addSubviews([messageView])
    }

    private func setupConstraints() {

        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        messageView.snp.makeConstraints { make in
            make.width.equalTo(240)
            make.bottom.top.equalToSuperview().inset(8)
            self.leftConstraint = make.left.equalToSuperview().inset(8).constraint
            self.rightConstraint = make.right.equalToSuperview().inset(8).constraint
        }
    }
}

extension MessageCell: ConfigurableTableViewCell {

    func configure(withItem item: CellItem) {
        guard let item = item as? MessageCellItem else { return }
        let message = item.messageData

        rightConstraint?.activate()
        leftConstraint?.activate()

        if message.isFromUser {
            leftConstraint?.deactivate()
            messageView.background(color: Asset.Colors.greenAccent)
            messageLabel.textAlignment = .right
        } else {
            rightConstraint?.deactivate()
            messageView.background(color: Asset.Colors.blueAccent)
            messageLabel.textAlignment = .left
        }

        messageLabel.text(message.text)
    }
}
