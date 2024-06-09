//
//  ImportVC.swift
//  Luxcar
//
//  Created by mac on 30/01/2024.
//

import UIKit
import Toaster

class ImportVC: ParentViewController {

    var cars: [Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.btnBack.isHidden = true
        configreTableView()
        getImportCars(params: GetCarListInput(pageNumber: "0", numberOfItems: "0"))
    }
    
    func configreTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SmallCarTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "SmallCarTypeTableViewCell")
        tableView.register(UINib(nibName: "CarTVC", bundle: nil), forCellReuseIdentifier: "CarTVC")
    }
}


extension ImportVC: UITableViewDelegate , UITableViewDataSource {
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
        let vc = CarDetailsVC()
        vc.modalPresentationStyle = .fullScreen
        vc.car_Id = cars[indexPath.row].id ?? ""
        vc.isRequest = true
        self.present(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ImportVC {
    func getImportCars(params: GetCarListInput){
        K_Network.sendRequest(function: apiService.carList(params: params), success: { (code, msg, response)  in
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
