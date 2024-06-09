//
//  ImportCarVC.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 16/10/2023.
//

import UIKit
import Toaster

class ImportCarVC: UIViewController {
    
    var car: Car?
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage(stringUrl: car?.images[0] ?? "", placeHolder: UIImage(named: "Rectangle 574"), imgView: imgCar)
        lblBrand.text = car?.brand?.name
        lblModel.text = car?.model?.name
        lblYear.text = car?.year
        lblPrice.text = "Groos \(car?.grossPrice ?? 0) \(car?.currency ?? "")"
    }
    
    @IBAction func btnRequest(_ sender: UIButton){
        let isValid = validation(fullName:txtFullName.text ?? "", phoneNumber: txtPhoneNumber.text ?? "")
        if isValid{
            getOrder(carId: car?.id ?? "", params: GetOrderInput(fullName:txtFullName.text ?? "", phoneNumber: txtPhoneNumber.text ?? "", orderType: "import"))
        }
    }
}

extension ImportCarVC{
    func getOrder(carId: String, params: GetOrderInput){
        K_Network.sendRequest(function: apiService.getOrder(carId: carId, params: params), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: DataResult.self , keyPath: nil)
                Toast(text: response.message).show()
                let vc = ImportSuccessVC()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
}

extension ImportCarVC {
    
    func validation(fullName: String, phoneNumber: String) -> Bool {
        var isValid = true
        let fullNameValidation = fullName.validateName()
        if !fullNameValidation.isValid {
            Toast(text: fullNameValidation.errorMessage ?? "field is required.").show()
            isValid = false
        }
        
        let phoneNumberValidation = phoneNumber.validatePhoneNumber()
        if !phoneNumberValidation.isValid {
            Toast(text: phoneNumberValidation.errorMessage ?? "Invalid phone number").show()
            isValid = false
        }
        return isValid
    }
}

