//
//  CarDetailsOptionsTVC.swift
//  Luxcar
//
//  Created by mac on 31/01/2024.
//

import UIKit

class CarDetailsOptionsTVC: UITableViewCell  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHieght: NSLayoutConstraint!
    var attriibutes: [Attribute] = []
    var options: [Option] = []
    func configre(attriibutes: [Attribute] , options: [Option]){
        self.attriibutes = attriibutes
        self.options = options
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AttributesTVC", bundle: nil), forCellReuseIdentifier: "AttributesTVC")
        tableView.register(UINib(nibName: "OptionsTVC", bundle: nil), forCellReuseIdentifier: "OptionsTVC")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableViewHieght.constant = tableView.contentSize.height
    }
}

extension CarDetailsOptionsTVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attriibutes.count + options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row <= attriibutes.count - 1 {
            guard let attriibutesCell = tableView.dequeueReusableCell(withIdentifier: "AttributesTVC", for: indexPath) as? AttributesTVC else {return UITableViewCell()}
            attriibutesCell.configreAttribute(attribute: attriibutes[indexPath.row])
            if indexPath.row == attriibutes.count - 1 {
                attriibutesCell.sepertorView.isHidden = false
            }
            return attriibutesCell
        }
        else {
            guard let optionsCell = tableView.dequeueReusableCell(withIdentifier: "OptionsTVC", for: indexPath) as? OptionsTVC else {return UITableViewCell()}
            if indexPath.row == 0 {
                optionsCell.lblOptionTitle.isHidden = false
            }
            optionsCell.configreOption(option: options[0])
            return optionsCell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
