import Foundation

struct AccountCellItem {
    let name: String
    let balance: Double
}

extension AccountCellItem: CellItem {

    var identifier: String {
        return AccountCell.identifier
    }
}
