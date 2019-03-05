import UIKit

extension UIViewController {

    public func showError(title: String? = nil, message: String?, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title ?? "Atenção",
                                      message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
