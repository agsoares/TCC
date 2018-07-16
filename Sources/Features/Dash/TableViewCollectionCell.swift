import UIKit

class TableViewCollectionViewCell: UITableViewCell {

    static var identifier: String = {
        return "\(TableViewCollectionViewCell.self)"
    }()

    let collectionView: UICollectionView = {
        let c = UICollectionView()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
}
