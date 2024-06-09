//
//  SearchTVC.swift
//  Luxcar
//
//  Created by mac on 29/01/2024.
//

import UIKit

class SearchTVC: UITableViewCell {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var txtSearch: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}




