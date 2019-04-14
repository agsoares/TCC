import UIKit

class TextField: UITextField {

    private var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.mediumBackground.color
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = Asset.Colors.lightText.color
        self.font = FontFamily.OpenSans.regular.font(size: 14)
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubviews([bottomLine])
    }

    private func setupConstraints() {
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-2)
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
    }
}

extension TextField {

    @discardableResult
    func placeholder(_ placeholder: String?) -> TextField {

        self.attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: Asset.Colors.mediumText.color])
        return self
    }

    @discardableResult
    func secure(_ secure: Bool = true) -> TextField {

        self.isSecureTextEntry = secure
        return self
    }
}
