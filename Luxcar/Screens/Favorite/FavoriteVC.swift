//
//  FavoriteVC.swift
//  Luxcar
//
//  Created by mac on 30/01/2024.
//

import UIKit
import Toaster

class FavoriteVC: ParentViewController{
    
    @IBOutlet weak var noDataView: UIView!
    
    var cars: [Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.btnBack.isHidden = true
        configreTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupHeaderViewButtons()
        getFavoritesCars(params: GetFavoriteListInput(pageNumber: "1", numberOfItems: "100"))
    }
    
    func configreTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SmallCarTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "SmallCarTypeTableViewCell")
        tableView.register(UINib(nibName: "CarTVC", bundle: nil), forCellReuseIdentifier: "CarTVC")
    }
    
}

extension FavoriteVC: UITableViewDelegate , UITableViewDataSource {
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
        self.present(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavoriteVC {
    func getFavoritesCars(params: GetFavoriteListInput){
        K_Network.sendRequest(function: apiService.favouriteList(params: params), success: { (code, msg, response)  in
            do {
                let car = try response.map(to: [Car].self, keyPath: "dataResult.car")

                
                
                self.cars = car
                if self.cars.count > 0 {
                    self.noDataView.isHidden = true
                    self.tableView.isHidden = false
                }else{
                    self.noDataView.isHidden = false
                    self.tableView.isHidden = true
                }
                self.tableView.reloadData()
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
}
