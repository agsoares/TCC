//
//  ChatTableViewCell.swift
//  TCC
//
//  Created by Adriano Guimarães Soares on 04/10/18.
//  Copyright © 2018 Adriano Soares. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    static let identifier = "ChatTableViewCell"

    @IBOutlet private weak var messageView: UIView!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private var rightConstraint: NSLayoutConstraint!
    @IBOutlet private var leftConstraint: NSLayoutConstraint!

    var message: MessageData?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(withMessage message: MessageData) {
        self.message = message

        rightConstraint.isActive = true
        leftConstraint.isActive  = true

        if message.isFromUser {
            leftConstraint.isActive = false
            messageView.backgroundColor = Asset.Colors.primary.color
            messageLabel.textAlignment = .right
        } else {
            rightConstraint.isActive = false
            messageView.backgroundColor = Asset.Colors.secundary.color
            messageLabel.textAlignment = .left
        }

        messageLabel.text = message.text

    }
}
