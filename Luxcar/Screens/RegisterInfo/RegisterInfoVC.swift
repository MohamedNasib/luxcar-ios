//
//  RegisterInfoVC.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 25/09/2023.
//

import UIKit
import Toaster

class RegisterInfoVC: UIViewController {
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
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
        let isValid = validation(fullName:txtFullName.text ?? "", phoneNumber: txtPhoneNumber.text ?? "", password: txtPassword.text ?? "", confirmPassword: txtConfirmPassword.text ?? "")
        if isValid{
            register(params: RegisterInput(fullName:txtFullName.text ?? "", phoneNumber: txtPhoneNumber.text ?? "", password: txtPassword.text ?? "", confirmPassword: txtConfirmPassword.text ?? ""))
        }
    }
}

extension RegisterInfoVC {
    
    func register(params: RegisterInput){
        K_Network.sendRequest(function: apiService.register(params: params), success: { (code, msg, response)  in
            do {
                    let auth = try response.map(to: User.self)
                self.login(params: LoginInput(phoneNumber: self.txtPhoneNumber.text ?? "", password: self.txtPassword.text ?? ""))
//                    K_Defaults.setValue(auth.token, forKey: Saved.TOKEN)
//                    K_Defaults.setValue(params.phoneNumber, forKey: Saved.PHONE_NUMBER)
//                    K_AppDelegate.redirectToHome()
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    func login(params: LoginInput){
        K_Network.sendRequest(function: apiService.login(params: params), success: { (code, msg, response)  in
            do {
                let auth = try response.map(to: User.self)
                K_Defaults.setValue(auth.token, forKey: Saved.TOKEN)
                self.addDeviceToken(params: AddTokenInput(deviceToken: auth.token))
                
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    func addDeviceToken(params: AddTokenInput){
        K_Network.sendRequest(function: apiService.addDeviceToken(params: params), success: { (code, msg, response)  in
            do {
                let auth = try response.map(to: UserProfileResponse.self)
                K_Defaults.setValue(auth.userProfile.phoneNumber, forKey: Saved.PHONE_NUMBER)
                K_AppDelegate.redirectToHome()
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
}

extension RegisterInfoVC {
    
    func validation(fullName: String, phoneNumber: String, password: String , confirmPassword: String) -> Bool {
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
