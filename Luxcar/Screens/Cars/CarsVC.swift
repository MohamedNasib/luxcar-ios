//
//  CarsVC.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 26/09/2023.
//

import UIKit
import Toaster

class CarsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var brands: [Brand] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBrandList(params: GetBrandListInput(pageNumber: "0", numberOfItems: "0"))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CarsTableViewCell", bundle: nil), forCellReuseIdentifier: "CarsTableViewCell")  
    }
    
    func getBrandList(params: GetBrandListInput){
        K_Network.sendRequest(function: apiService.brandList(params: params), success: { (code, msg, response)  in
            do {
                self.brands = try response.map(to: [Brand].self, keyPath: "dataResult")
                self.tableView.reloadData()
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
}



extension CarsVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let brandCell = tableView.dequeueReusableCell(withIdentifier: "CarsTableViewCell", for: indexPath) as? CarsTableViewCell else{return UITableViewCell()}
        brandCell.configure(brand: brands[indexPath.row])
        return brandCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = BrandVC()
        vc.brand = brands[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

