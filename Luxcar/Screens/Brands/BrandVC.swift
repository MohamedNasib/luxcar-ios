//
//  BrandVC.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 26/09/2023.
//

import UIKit
import Toaster

class BrandVC: ParentViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var brand: Brand?
    var models: [Model] = []
    var cars: [Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.title.text = brand?.name ?? ""
        configre()
    }
    
    func configre(){
        self.models = brand?.model ?? []
        self.models.insert(Model(_id: "0", name: "All" , isSelected: true), at: 0)
        getCarByBrand(id: brand?._id ?? "", params: GetBrandListInput(pageNumber: "0", numberOfItems: "0"))
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.register(UINib(nibName: "SmallCarTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "SmallCarTypeTableViewCell")
        tableView.register(UINib(nibName: "CarTVC", bundle: nil), forCellReuseIdentifier: "CarTVC")
        collectionView.register(UINib(nibName: "BrandModelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BrandModelCollectionViewCell")
    }
    

    func getCarByBrand(id: String , params: GetBrandListInput){
        K_Network.sendRequest(function: apiService.getCarBrand(id: id, params: params), success: { (code, msg, response)  in
            do {
                self.cars = try response.map(to: [Car].self, keyPath: "dataResult")
                self.tableView.reloadData()
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    } 
    
    func getCarByModel(id: String , params: GetModelListInput){
        K_Network.sendRequest(function: apiService.getCarModel(id: id, params: params), success: { (code, msg, response)  in
            do {
                self.cars = try response.map(to: [Car].self, keyPath: "dataResult")
                self.tableView.reloadData()
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }


}


extension BrandVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isListed = K_Defaults.bool(forKey: Saved.IS_LISTED)
        if isListed {
            guard let listCell = tableView.dequeueReusableCell(withIdentifier: "SmallCarTypeTableViewCell", for: indexPath) as? SmallCarTypeTableViewCell else{return UITableViewCell()}
            listCell.configre(car: cars[indexPath.row])
            return listCell
        } else {
            guard let catigoriesCell = tableView.dequeueReusableCell(withIdentifier: "CarTVC", for: indexPath) as? CarTVC else{return UITableViewCell()}
            catigoriesCell.configre(car: cars[indexPath.row])
            return catigoriesCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let vc = BrandVC()
//        vc.brandId = self.brands[indexPath.row]._id
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
    }
}



extension BrandVC: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandModelCollectionViewCell", for: indexPath) as? BrandModelCollectionViewCell else {return UICollectionViewCell()}
        cell.configre(model: models[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        setupModelsSelection(selectedIndex: indexPath)
        collectionView.reloadData()
        if indexPath.row == 0 {
            getCarByBrand(id: brand?._id ?? "", params: GetBrandListInput(pageNumber: "1", numberOfItems: "10"))
        } else {
            getCarByModel(id: models[indexPath.row]._id , params: GetModelListInput(pageNumber: "1", numberOfItems: "10"))
        }
    }
    
    func setupModelsSelection(selectedIndex: IndexPath){
        for i in stride(from: 0, to: models.count , by: 1) {
            models[i].isSelected = false
        }
        models[selectedIndex.row].isSelected = !models[selectedIndex.row].isSelected
    }
//    
//    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = models[indexPath.row].name
        return CGSize(width: (text as NSString).size(withAttributes: [NSAttributedString.Key.font: AppFontSystem.medium.size(14)]).width + 60, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
}
