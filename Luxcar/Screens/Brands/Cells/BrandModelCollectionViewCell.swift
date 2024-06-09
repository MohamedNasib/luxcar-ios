//
//  BrandModelCollectionViewCell.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 26/09/2023.
//

import UIKit

class BrandModelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblModelTitle: UILabel!
    
    func configre(model: Model){
        lblModelTitle.text = model.name
        if model.isSelected == true {
            lblModelTitle.textColor = .white
            lblModelTitle.superview?.backgroundColor = UIColor(named: "Primary")
        }else {
            lblModelTitle.textColor = .black
            lblModelTitle.superview?.backgroundColor = UIColor(named: "#CECECE OPacity")
        }
    }
}
