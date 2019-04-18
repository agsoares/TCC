import UIKit
import SnapKit

private struct Constants {
    static let imageSize: CGFloat = 24
}

class AccountCell: UITableViewCell {

    private var containerView: UIView = {
        return UIView(frame: .zero)
            .background(color: Asset.Colors.mediumBackground)
            .rounded(radius: 8)
    }()

    private var nameLabel: Label = {
        return Label()
            .style(style: .r16)
            .color(Asset.Colors.mediumText)
    }()

    private var balanceLabel: Label = {
        return Label()
            .style(style: .r16)
    }()

    private var iconView: UIImageView = {
        return UIImageView(frame: .zero)
            .background(color: Asset.Colors.darkBackground)
            .rounded()

    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        nameLabel.text = "Nome"
        balanceLabel.text = "blabla"
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        selectionStyle = .none
        background(color: Asset.Colors.darkBackground)

        contentView.addSubviews([containerView])
        containerView.addSubviews([iconView, nameLabel, balanceLabel])
    }

    private func setupConstraints() {

        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(8)
        }

        iconView.snp.makeConstraints { (make) in
            make.width.equalTo(Constants.imageSize)
            make.height.equalTo(Constants.imageSize)
            make.left.bottom.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(24)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(16)
            make.centerY.equalTo(iconView.snp.centerY)
        }

        balanceLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(nameLabel.snp.centerY)
        }
    }
}

extension AccountCell: ConfigurableTableViewCell {
    func configure(withItem item: CellItem) {
        
        guard let accountItem = item as? AccountCellItem else { return }
        nameLabel.text(accountItem.name)
        let balanceColor = accountItem.balance >= 0 ? Asset.Colors.green : Asset.Colors.red
        balanceLabel
            .text(accountItem.balance.currency())
            .color(balanceColor)
    }
}
