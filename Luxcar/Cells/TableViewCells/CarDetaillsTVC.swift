//
//  CarDetaillsTVC.swift
//  Luxcar
//
//  Created by mac on 31/01/2024.
//

import UIKit

class CarDetaillsTVC: UITableViewCell {
//    @IBOutlet weak var lblOfferNumber: UILabel!
//    @IBOutlet weak var lblExteriorColor: UILabel!
//    @IBOutlet weak var lblInteriorColor: UILabel!
//    @IBOutlet weak var lblPreviousOwners: UILabel!
//    @IBOutlet weak var lblMileage: UILabel!
//    @IBOutlet weak var lblSeats: UILabel!
//    @IBOutlet weak var lblM_Y: UILabel!
//    @IBOutlet weak var lblTransmission: UILabel!
//    @IBOutlet weak var lblDrive: UILabel!
//    @IBOutlet weak var lblCapacity: UILabel!
//    @IBOutlet weak var lblPower_kW: UILabel!
//    @IBOutlet weak var lblPower_PS: UILabel!
//    @IBOutlet weak var lblFirstRegistration: UILabel!
//    @IBOutlet weak var lblEmissionStandard: UILabel!
//    @IBOutlet weak var lblFuelConsumption_in_town: UILabel!
//    @IBOutlet weak var lblFuelConsumption_out_town: UILabel!
//    @IBOutlet weak var lblFuelConsumption_comb: UILabel!
//    @IBOutlet weak var lblEmissions: UILabel!
//    @IBOutlet weak var EfficiencyRating: UILabel!
//    @IBOutlet weak var Engine: UILabel!
    
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_year: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_offerNumber: UILabel!
    @IBOutlet weak var lbl_mileAge: UILabel!
    @IBOutlet weak var lbl_currency: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var lbl_carImport: UILabel!
    @IBOutlet weak var lbl_carStatus: UILabel!
    @IBOutlet weak var lbl_grossPrice: UILabel!
    @IBOutlet weak var lbl_netExportPrice: UILabel!
    
    func configure(car: Car?){
//        self.lblOfferNumber.text = car.offerNumber
//        self.lblExteriorColor.text = ""
//        self.lblInteriorColor.text = ""
//        self.lblPreviousOwners.text = ""
//        self.lblMileage.text = car.mileAge
//        self.lblSeats.text = ""
//        self.lblM_Y.text = ""
//        self.lblTransmission.text = ""
//        self.lblDrive.text = ""
//        self.lblCapacity.text = ""
//        self.lblPower_kW.text = ""
//        self.lblPower_PS.text = ""
//        self.lblFirstRegistration.text = ""
//        self.lblEmissionStandard.text = ""
//        self.lblFuelConsumption_in_town.text = ""
//        self.lblFuelConsumption_out_town.text = ""
//        self.lblFuelConsumption_comb.text = ""
//        self.lblEmissions.text = ""
//        self.EfficiencyRating.text = ""
//        self.Engine.text = ""
        
        self.lbl_name.text = car?.name
        self.lbl_year.text = car?.year
        self.lbl_description.text = car?.description
        self.lbl_offerNumber.text = car?.offerNumber
        self.lbl_mileAge.text = car?.mileAge
        self.lbl_currency.text = car?.currency
        self.lbl_status.text = car?.status
        self.lbl_carImport.text = car?.carImport
        self.lbl_carStatus.text = car?.carStatus
        self.lbl_grossPrice.text = "\(car?.grossPrice ?? 0)"
        self.lbl_netExportPrice.text = "\(car?.netExportPrice ?? 0)"
        
    }
}
