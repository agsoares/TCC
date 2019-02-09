import UIKit

protocol ReusableCell {}

extension ReusableCell {

    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableCell {}

extension UICollectionViewCell: ReusableCell {}

protocol ConfigurableTableViewCell: ReusableCell {

    func configure(withItem item: CellItem)
}

protocol ConfigurableCollectionViewCell: ReusableCell {

    func configure(withItem item: CellItem)
}

extension UITableView {

    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }

    func registerNib<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(UINib(nibName: cellClass.identifier, bundle: Bundle(for: cellClass)), forCellReuseIdentifier: cellClass.identifier)
    }

    func dequeueAndConfigure(withItem item: CellItem, forIndexPath indexPath: IndexPath) -> UITableViewCell {

        guard let configurableCell = self.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath) as? ConfigurableTableViewCell else {
            fatalError("Could not dequeue cell \(item.identifier) at \(indexPath)")
        }
        configurableCell.configure(withItem: item)
        guard let cell = configurableCell as? UITableViewCell else {
            fatalError("Could not transform \(item.identifier) into UITableViewCell")
        }
        return cell
    }
}
