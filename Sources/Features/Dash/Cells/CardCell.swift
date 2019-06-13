import UIKit
import SnapKit

private struct Constants {
    static let imageSize: CGFloat = 32
}

class CardCell: UITableViewCell {

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

    private var owedLabel: Label = {
        return Label()
            .style(style: .r16)
            .color(Asset.Colors.mediumText)
    }()

    private var availableLimitLabel: Label = {
        return Label()
            .style(style: .r14)
            .color(Asset.Colors.mediumText)
    }()

    private var iconContainer: UIView = {
        return UIView(frame: .zero)
            .background(color: Asset.Colors.darkBackground)
            .rounded()
    }()

    private var iconView: UIImageView = {
        return UIImageView(frame: .zero)
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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
        iconContainer.addSubviews([iconView])
        containerView.addSubviews([iconContainer, nameLabel, availableLimitLabel, owedLabel])
    }

    private func setupConstraints() {

        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(8)
            make.height.equalTo(62)
        }

        iconContainer.snp.makeConstraints { (make) in
            make.width.equalTo(Constants.imageSize)
            make.height.equalTo(Constants.imageSize)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }

        iconView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(8)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconContainer.snp.right).offset(8)
            make.top.equalToSuperview().inset(8)
        }

        availableLimitLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom)
        }

        owedLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(nameLabel.snp.centerY)
        }
    }
}

extension CardCell: ConfigurableTableViewCell {
    func configure(withItem item: CellItem) {

        guard let cardItem = item as? CardCellItem else { return }
        iconView.contentMode = .scaleAspectFit
        iconView.image = Asset.Assets.card.image.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = Asset.Colors.greenAccent.color
        nameLabel.text(cardItem.name)

        owedLabel
            .text(cardItem.owed.currency())

        availableLimitLabel
            .text("Limite disponível: " + (cardItem.availableLimit.currency() ?? ""))

    }
}
