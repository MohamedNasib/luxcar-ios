import UIKit
import Nuke

extension UICollectionViewCell {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func loadImage(stringUrl: String, placeHolder: UIImage?, imgView: UIImageView) {
        if !stringUrl.isEmpty, let url = URL(string: stringUrl) {
            let options = ImageLoadingOptions(
                placeholder: placeHolder,
                transition: .fadeIn(duration: 0.0),
                failureImage: placeHolder
            )
            Nuke.loadImage(with: url, options: options, into: imgView)
        }
    }
}
