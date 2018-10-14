import UIKit

class TabBarController: UITabBarController {

    convenience init(viewControllers: [UIViewController]) {
        self.init(nibName: nil, bundle: nil)

        self.viewControllers = viewControllers

        self.tabBar.items?[0].image = Asset.Assets.earnings.image
        self.tabBar.items?[1].image = Asset.Assets.chat.image
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
