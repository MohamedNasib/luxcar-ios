//
//  SearchVC.swift
//  Luxcar
//
//  Created by mac on 30/01/2024.
//

import UIKit
import Toaster

class SearchVC: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    var cars: [Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SmallCarTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "SmallCarTypeTableViewCell")
        getCarSearch(params: CarSearchInput(pageNumber: "0", numberOfItems: "0", name: txtSearch.text ?? "", carStatus: txtSearch.text ?? "", carImport: txtSearch.text ?? "", description: txtSearch.text ?? ""))
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != ""  {
            btnClose.isHidden = false
            btnClose.isEnabled = true
        }else{
            btnClose.isHidden = true
            btnClose.isEnabled = false
        }
        getCarSearch(params: CarSearchInput(pageNumber: "0", numberOfItems: "0", name: txtSearch.text ?? "", carStatus: txtSearch.text ?? "", carImport: txtSearch.text ?? "", description: txtSearch.text ?? ""))
    }

    @IBAction func btnClosePressed(_ sender: UIButton){
        txtSearch.text = ""
    }
}

extension SearchVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SmallCarTypeTableViewCell", for: indexPath) as? SmallCarTypeTableViewCell else{return UITableViewCell()}
        cell.configre(car: cars[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CarDetailsVC()
        vc.modalPresentationStyle = .fullScreen
        vc.car_Id = cars[indexPath.row].id ?? ""
        self.present(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchVC{
    
    func getCarSearch(params: CarSearchInput) {
        K_Network.sendRequest(function: apiService.carSearch(params: params) , showLoader: false, success: { (code, msg, response)  in
            do {
                let dataResult = try response.map(to: DataResult.self)
                self.cars = try response.map(to: [Car].self, keyPath: "dataResult")
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
