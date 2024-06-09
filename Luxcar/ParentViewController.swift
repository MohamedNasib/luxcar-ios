//
//  ParentViewController.swift
//  Luxcar
//
//  Created by mac on 30/01/2024.
//

import UIKit

class ParentViewController: UIViewController {
    
    @IBOutlet weak var headerView: HeaderView_DoubleIcon!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        headerViewSetup()
    }
    
    func headerViewSetup(){
        setupHeaderViewButtons()
        headerView.btnListed.addTarget(self, action: #selector(btnListedPressed), for: .touchUpInside)
        headerView.btnCatigories.addTarget(self, action: #selector(btnCatigoriesPressed), for: .touchUpInside)
    }
    
    func setupHeaderViewButtons(){
        if K_Defaults.bool(forKey: Saved.IS_LISTED) == true {
            headerView.btnListed.setImage(UIImage(named: "Icons 2"), for: .normal)
            headerView.btnCatigories.setImage(UIImage(named: "Icons 1"), for: .normal)
        }else {
            headerView.btnListed.setImage(UIImage(named: "Icons 3"), for: .normal)
            headerView.btnCatigories.setImage(UIImage(named: "Icons"), for: .normal)
        }
    }
    
    @objc func btnListedPressed(){
        K_Defaults.setValue(true, forKey: Saved.IS_LISTED)
        setupHeaderViewButtons()
        tableView.reloadData()
    }

    @objc func btnCatigoriesPressed(){
        K_Defaults.setValue(false, forKey: Saved.IS_LISTED)
        setupHeaderViewButtons()
        tableView.reloadData()
    }

}
