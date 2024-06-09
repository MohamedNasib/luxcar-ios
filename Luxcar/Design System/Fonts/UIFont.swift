//
//  UIFont.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 20/09/2023.
//

import UIKit

extension UIFont {

    class func regularFont(_ size: CGFloat) -> UIFont? {

        return UIFont(name: "Poppins-Regular", size: size )

    }
    
    class func semiBold(_ size: CGFloat) -> UIFont? {

        return UIFont(name: "Poppins-SemiBold", size: size)

    }
    
    class func boldFont(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Bold", size: size)
    }
    
    class func mediumFont(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Medium", size: size)
    }
}
