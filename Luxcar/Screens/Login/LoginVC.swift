//
//  LoginVC.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 20/09/2023.
//

import UIKit
import Toaster

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var window: UIWindow?
    var vc: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showPasswordBtn(_ sender: UIButton){
        txtPassword.isSecureTextEntry.toggle()
    }

    @IBAction func forgetPasswordBtn(_ sender: UIButton){
        let forgetPasswordVC = ForgetPasswordVC()
        forgetPasswordVC.modalPresentationStyle = .fullScreen
        self.present(forgetPasswordVC, animated: true)
    }
    
    @IBAction func btnSinupPressed(_ sender: UIButton){
        let registerVC = RegisterVC()
        registerVC.modalPresentationStyle = .fullScreen
        self.present(registerVC, animated: true)
    }

    @IBAction func btnLoginPressed(_ sender: UIButton){
        let isValid = validation(phoneNumber: txtPhoneNumber.text ?? "", password: txtPassword.text ?? "")
        if isValid{
            login(params: LoginInput(phoneNumber: txtPhoneNumber.text ?? "", password: txtPassword.text ?? ""))
        }
    }
    
    @IBAction func guestPressed(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "tabController")
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }

}


extension LoginVC {
    
    func login(params: LoginInput){
        K_Network.sendRequest(function: apiService.login(params: params), success: { (code, msg, response)  in
            do {
                let auth = try response.map(to: User.self)
                K_Defaults.setValue(auth.token, forKey: Saved.TOKEN)
                self.addDeviceToken(params: AddTokenInput(deviceToken: auth.token))
                
            } catch {
                print(msg)
            }
        }) { (code, msg, errors) in
            print(msg)
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
                print(msg)
            }
        }) { (code, msg, errors) in
            print(msg)
            Toast(text: msg).show()
        }
    }
    
}


extension LoginVC {
    
    func validation(phoneNumber: String, password: String) -> Bool {
        var isValid = true
        
        let phoneNumberValidation = phoneNumber.validatePhoneNumber()
        if !phoneNumberValidation.isValid {
            Toast(text: phoneNumberValidation.errorMessage ?? "Invalid phone number").show()
            isValid = false
        } else {
            
        }
        
        let passwordValidation = password.validatePassword()
        if !passwordValidation.isValid {
            Toast(text: passwordValidation.errorMessage ?? "Invalid password").show()
            isValid = false
        } else {
            
        }
        
        return isValid
    }
}
