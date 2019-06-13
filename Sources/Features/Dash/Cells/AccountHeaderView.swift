import Foundation
import RxSwift
import SnapKit

final class AccountHeaderView: UIView {

    let title: String

    private lazy var titleLabel: Label = {
        return Label()
            .style(style: .r14)
            .color(Asset.Colors.mediumText)
            .text(self.title)
    }()

    private var addAccountButton: ActionButton = {
        return ActionButton(frame: .zero)
            .rounded()
            .dark()
            .title("+")
    }()

    init(title: String) {
        self.title = title
        super.init(frame: .zero)

        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = Asset.Colors.darkBackground.color
        addSubviews([titleLabel, addAccountButton])
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
        }

        addAccountButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(addAccountButton.snp.width)
            make.width.equalTo(20)
        }
    }
}
