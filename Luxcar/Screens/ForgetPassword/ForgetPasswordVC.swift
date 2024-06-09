//
//  ForgetPasswordVC.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 20/09/2023.
//

import UIKit
import Toaster

class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func continueBtn(_ sender: UIButton){
        let isValid = validation(phoneNumber: txtPhoneNumber.text ?? "")
        if isValid{
            AuthManager.shared.startAuth(phoneumber: "+2\(self.txtPhoneNumber.text ?? "")") { [weak self] success in
                guard success else{return}
                DispatchQueue.main.async {
                    K_Defaults.set(self?.txtPhoneNumber.text ?? "", forKey: Saved.PHONE_NUMBER)
                    let verficationCodeVC = VerficationCodeVC()
                    verficationCodeVC.contex = NewPasswordVC()
                    verficationCodeVC.phoneNumber = self?.txtPhoneNumber.text ?? ""
                    verficationCodeVC.modalPresentationStyle = .fullScreen
                    self?.present(verficationCodeVC, animated: true)
                }
            }
        }
    }
}

extension ForgetPasswordVC {
    func validation(phoneNumber: String) -> Bool {
        var isValid = true
        let phoneNumberValidation = phoneNumber.validatePhoneNumber()
        if !phoneNumberValidation.isValid {
            Toast(text: phoneNumberValidation.errorMessage ?? "Invalid phone number").show()
            isValid = false
        }
        return isValid
    }
}
