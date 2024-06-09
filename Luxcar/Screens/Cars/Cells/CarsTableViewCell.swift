//
//  CarsTableViewCell.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 26/09/2023.
//

import UIKit

class CarsTableViewCell: UITableViewCell {
    @IBOutlet weak var imgbrandLogo: UIImageView!
    @IBOutlet weak var lblBrandName: UILabel!
    
    func configure(brand: Brand){
        loadImage(stringUrl: brand.brandLogo, placeHolder: nil, imgView: imgbrandLogo)
        lblBrandName.text = brand.name
    }
}
