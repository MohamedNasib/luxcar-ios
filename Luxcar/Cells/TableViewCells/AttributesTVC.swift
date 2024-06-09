//
//  AttributesTVC.swift
//  Luxcar
//
//  Created by mac on 31/01/2024.
//

import UIKit

class AttributesTVC: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var sepertorView: UIView!
    
    func configreAttribute(attribute: Attribute){
        img.setIconColor(AppColorSystem.primary.color)
        loadImage(stringUrl: attribute.key, placeHolder: UIImage(named: "checkbox-circle-fill"), imgView: img)
        lblDescription.text = attribute.value
        img.setIconColor(AppColorSystem.primary.color)
        img.tintColor = AppColorSystem.primary.color
        
    }
}
