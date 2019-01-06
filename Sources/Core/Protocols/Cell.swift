import Foundation

protocol Cell {
    static var identifier: String { get }
    func configure(withItem item: CellItem)
}
