import Foundation

struct CardCellItem {
    let name: String
    let owed: Double
    let availableLimit: Double
}

extension CardCellItem: CellItem {

    var identifier: String {
        return CardCell.identifier
    }
}
