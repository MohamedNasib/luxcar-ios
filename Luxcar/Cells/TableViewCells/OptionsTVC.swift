//
//  OptionsTVC.swift
//  Luxcar
//
//  Created by mac on 31/01/2024.
//

import UIKit

class OptionsTVC: UITableViewCell {

    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblOptionTitle: UILabel!
    
    func configreOption(option: Option){
        lblKey.text = option.code
        lblDescription.text = option.description
    }
}
