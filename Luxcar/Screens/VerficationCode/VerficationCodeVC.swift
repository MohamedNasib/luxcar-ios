//
//  VerficationCodeVC.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 20/09/2023.
//

import UIKit
import OTPFieldView
import Toaster


class VerficationCodeVC: UIViewController, OTPFieldViewDelegate {

    @IBOutlet var otpTextFieldView: OTPFieldView!
    @IBOutlet var btnContinue: UIButton!
    var otpCode = ""
    var contex = UIViewController()
    var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOtpView()
    }
    
    func setupOtpView(){
        self.otpTextFieldView.fieldsCount = 6
        self.otpTextFieldView.fieldBorderWidth = 0
//        self.otpTextFieldView.filledBorderColor = AppColorSystem.titleGray.color
        self.otpTextFieldView.cursorColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
        self.otpTextFieldView.defaultBackgroundColor = AppColorSystem.otpBG.color
        self.otpTextFieldView.displayType = .roundedCorner
        self.otpTextFieldView.fieldSize = 36
        self.otpTextFieldView.separatorSpace = 24
        self.otpTextFieldView.shouldAllowIntermediateEditing = true
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
        for item in self.otpTextFieldView.subviews {
            item.layer.cornerRadius = 5
        }
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        otpCode = otp
    }
    
    @IBAction func btnContinuePressed(_ sender: UIButton){
        AuthManager.shared.verifyCode(smsCode: otpCode) { [weak self] success in
            guard success else{return}
            DispatchQueue.main.async {
                guard let context = self?.contex else {return}
                context.modalPresentationStyle = .fullScreen
                self?.present(context, animated: true)
            }
        }
        
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        print("Has entered all OTP? \(hasEnteredAll)")
        if hasEnteredAll {
            btnContinue.backgroundColor =  UIColor(named: "Primary")?.withAlphaComponent(1.0)
            btnContinue.isEnabled =  true
            return true
        }else{
            btnContinue.backgroundColor =  UIColor(named: "Primary")?.withAlphaComponent(0.6)
            btnContinue.isEnabled =  false
            return false
        }
    }

}
