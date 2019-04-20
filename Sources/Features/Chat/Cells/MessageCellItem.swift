import Foundation

struct MessageCellItem: CellItem {
    var identifier: String {
        return MessageCell.identifier
    }

    var messageData: MessageData
}
