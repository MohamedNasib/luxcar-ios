//
//  UIImageView+Extensions.swift
//
//  Created by Ahmed El-elaimy.
//

import UIKit

extension UIImage {
    func tinted(with color: UIColor, isOpaque: Bool = false) -> UIImage? {
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            color.set()
            withRenderingMode(.alwaysTemplate).draw(at: .zero)
        }
    }
}

extension UIImageView {

    @IBInspectable var iconColor: UIColor? {
        get {
            return self.tintColor
        }
        set {
            // Ensure the image is of template rendering mode
            self.image = self.image?.withRenderingMode(.alwaysTemplate)
            self.tintColor = newValue
        }
    }

    // Function to set the icon color from code
    func setIconColor(_ color: UIColor?) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }

    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }

    @IBInspectable
    var imageAlpha: CGFloat {
        get {
            return self.alpha
        }
        set {
            self.alpha = newValue
        }
    }
}


@IBDesignable
extension UIButton {
    
    @IBInspectable
    var imageOverlayColor: UIColor? {
        get {
            // This is a dummy return as you cannot retrieve the color information directly from the image
            // Typically for @IBDesignable, we don't need getters
            return nil
        }
        set {
            guard let color = newValue else { return }
            let tintedImage = self.image(for: .normal)?.tinted(with: color)
            setImage(tintedImage, for: .normal)
        }
    }
    
}


extension UIImage {

    func resized(to targetSize: CGSize = CGSize(width: 30, height: 30)) -> UIImage {
        let rect = CGRect(origin: .zero, size: targetSize)

        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
        self.draw(in: rect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage ?? self
    }
}









