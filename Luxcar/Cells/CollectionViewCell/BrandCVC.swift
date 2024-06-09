//
//  BrandCVC.swift
//  Luxcar
//
//  Created by mac on 08/01/2024.
//

import UIKit

class BrandCVC: UICollectionViewCell {
    @IBOutlet weak var imgbrandLogo: UIImageView!
    @IBOutlet weak var lblBrandName: UILabel!
    
    func configure(brand: Brand){
        loadImage(stringUrl: brand.brandLogo, placeHolder: nil, imgView: imgbrandLogo)
        lblBrandName.text = brand.name
    }
}
