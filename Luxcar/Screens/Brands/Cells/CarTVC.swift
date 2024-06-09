//
//  CarTVC.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 02/10/2023.
//

import UIKit
import Toaster

class CarTVC: UITableViewCell {

    @IBOutlet weak var imgCarPhoto: UIImageView!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblCarNaame: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    var car_id  = ""
    var isFavorite = false
    
    func configre(car: Car){
        lblBrand.text = car.brand?.name
        lblCarNaame.text = car.name
        lblYear.text = car.year
        lblPrice.text = "\(formatNumber(Int(car.grossPrice)) ?? "0") \(car.currency)"
        if !(car.images.isEmpty ){
            loadImage(stringUrl: car.images[0] , placeHolder: UIImage(named: "Rectangle 574"), imgView: imgCarPhoto)
        }
        car_id = car.id 
    }
    
    func formatNumber(_ number: Int) -> String? {
        // Instantiate NumberFormatter
        let formatter = NumberFormatter()
        
        // Set formatter properties
        formatter.numberStyle = .decimal // This will automatically use the appropriate thousands separator for the locale
        
        // Format the number
        return formatter.string(from: NSNumber(value: number))
    }
    
    @IBAction func btnFavoritePressed(_ sender: UIButton){
        if isFavorite {
            deleteCarFromFavorite(carId: car_id)
        }else{
            addCarToFavorite(carId: car_id)
        }
        isFavorite = !isFavorite
    }
    
    func addCarToFavorite(carId: String){
        K_Network.sendRequest(function: apiService.addCarTofavorite(carId: carId), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: Favorite.self , keyPath: "dataResult")
                self.btnFavorite.setImage(UIImage(named: "Favourite 1"), for: .normal)
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }

    func deleteCarFromFavorite(carId: String){
        K_Network.sendRequest(function: apiService.deleteCarFromfavorite(carId: carId), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: Favorite.self , keyPath: "dataResult")
                self.btnFavorite.setImage(UIImage(named: "Favourite"), for: .normal)
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    
}
