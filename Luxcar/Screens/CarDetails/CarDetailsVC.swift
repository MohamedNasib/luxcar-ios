//
//  CarDetailsVC.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 03/10/2023.
//

import UIKit
import Toaster

class CarDetailsVC: UIViewController {
    

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnGetIt: UIButton!
    @IBOutlet weak var btnRequestImport: UIButton!
    
    var car_Id = ""
    var isRequest = false
    var car: Car?
    var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SliderImageTVC", bundle: nil), forCellReuseIdentifier: "SliderImageTVC")
        tableView.register(UINib(nibName: "CarDetaillsTVC", bundle: nil), forCellReuseIdentifier: "CarDetaillsTVC")
        tableView.register(UINib(nibName: "CarDetailsOptionsTVC", bundle: nil), forCellReuseIdentifier: "CarDetailsOptionsTVC")
        getCar(id: car_Id)
        if isRequest {
            btnRequestImport.isHidden = false
            btnGetIt.isHidden = true
        }else{
            btnGetIt.isHidden = false
            btnRequestImport.isHidden = true
        }
    }

}

extension CarDetailsVC{
    @IBAction func btnRequestImport(_ sender: UIButton){
        let vc = ImportCarVC()
        vc.modalPresentationStyle = .fullScreen
        vc.car = self.car
        self.present(vc, animated: true)
    }
    
    @IBAction func btnGetItImport(_ sender: UIButton){
        
    }
}

extension CarDetailsVC {
    func getCar(id: String){
        K_Network.sendRequest(function: apiService.getCar(id: id), success: { (code, msg, response)  in
            do {
                self.car = try response.map(to: Car.self, keyPath: "dataResult")
                self.lblBrand.text = self.car?.brand?.name
                self.lblModel.text = self.car?.model?.name
                self.tableView.reloadData()
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton){
        self.dismiss(animated: true)
    }
    
    @IBAction func btnFavoritePressed(_ sender: UIButton){
        if isFavorite {
            deleteCarFromFavorite(carId: car?.id ?? "")
        }else{
            addCarToFavorite(carId: car?.id ?? "")
        }
        isFavorite = !isFavorite
    }
}

extension CarDetailsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0 :guard let sliderCell = tableView.dequeueReusableCell(withIdentifier: "SliderImageTVC", for: indexPath) as? SliderImageTVC else {return UITableViewCell()}
                sliderCell.configure(car: car)
            return sliderCell
            case 1 :guard let carDetailsCell = tableView.dequeueReusableCell(withIdentifier: "CarDetaillsTVC", for: indexPath) as? CarDetaillsTVC else {return UITableViewCell()}
                carDetailsCell.configure(car: car)
            return carDetailsCell
            case 2 :guard let carDetailsOptionsCell = tableView.dequeueReusableCell(withIdentifier: "CarDetailsOptionsTVC", for: indexPath) as? CarDetailsOptionsTVC else {return UITableViewCell()}
            var attributes = car?.attributes
            attributes?.insert(Attribute(key: car?.brand?.brandLogo ?? "", value: "\(car?.carStatus ?? "") \(car?.brand?.name ?? "") \(car?.model?.name ?? "") \(car?.year ?? "")"), at: 0)
            carDetailsOptionsCell.configre(attriibutes: attributes ?? [] , options: car?.options ?? [])
            return carDetailsOptionsCell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
    
