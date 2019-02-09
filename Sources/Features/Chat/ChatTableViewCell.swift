//
//  ChatTableViewCell.swift
//  TCC
//
//  Created by Adriano Guimarães Soares on 04/10/18.
//  Copyright © 2018 Adriano Soares. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet private weak var messageView: UIView!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private var rightConstraint: NSLayoutConstraint!
    @IBOutlet private var leftConstraint: NSLayoutConstraint!
}

extension ChatTableViewCell: ConfigurableTableViewCell {

    func configure(withItem item: CellItem) {
        guard let item = item as? MessageDataItem else { return }
        let message = item.messageData

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

struct MessageDataItem: CellItem {
    var identifier: String {
        return ChatTableViewCell.identifier
    }

    var messageData: MessageData
}
