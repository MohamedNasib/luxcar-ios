//
//  NewPasswordVC.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 20/09/2023.
//

import UIKit
import Toaster

class NewPasswordVC: UIViewController {
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnPasswordEyePressed(_ sender: UIButton){
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
    }
    
    @IBAction func btnConfirmPasswordEyePressed(_ sender: UIButton){
        txtConfirmPassword.isSecureTextEntry = !txtConfirmPassword.isSecureTextEntry
    }
    
    @IBAction func btnSavePressed(_ sender: UIButton){
        let isValid = validation(password: txtPassword.text ?? "", confirmPassword: txtConfirmPassword.text ?? "")
        if isValid{
            let phoneNumber = K_Defaults.string(forKey: Saved.PHONE_NUMBER)
            forgetPassword(params: ForgetPasswordInput(phoneNumber: phoneNumber ?? "", password: txtPassword.text ?? "", confirmPassword: txtConfirmPassword.text ?? "") )
            
        }
    }

}

extension NewPasswordVC {
    
    func forgetPassword(params: ForgetPasswordInput){
        K_Network.sendRequest(function: apiService.forgetPassword(params: params), success: { (code, msg, response)  in
            do {
                let forgetResponse = try response.map(to: User.self)
                K_AppDelegate.redirectToHome()
                Toast(text: forgetResponse.message).show()
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
}


extension NewPasswordVC {
    
    func validation(password: String , confirmPassword: String) -> Bool {
        var isValid = true

        let passwordValidation = password.validatePassword()
        if !passwordValidation.isValid {
            Toast(text: passwordValidation.errorMessage ?? "Invalid password").show()
            isValid = false
        } 
        
        let confirmPasswordValidation = confirmPassword.validateConfirmPassword(password: password)
        if !confirmPasswordValidation.isValid {
            Toast(text: confirmPasswordValidation.errorMessage ?? "Invalid password").show()
            isValid = false
        } 
        
        return isValid
    }
}
