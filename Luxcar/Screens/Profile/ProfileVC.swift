//
//  ProfileVC.swift
//  Luxcar
//
//  Created by mac on 30/01/2024.
//

import UIKit
import Toaster

class ProfileVC: UIViewController {

    @IBOutlet weak var personalDetailsView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var rateAppView: UIView!
    @IBOutlet weak var shareAppView: UIView!
    
    var window: UIWindow?
    var vc: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personalDetailsView.onTap {
            self.navigateScreen(vc: NewPasswordVC())
        }
        contactView.onTap {
            self.navigateScreen(vc: ContactVC())
        }
        rateAppView.onTap {
            
        }
        shareAppView.onTap {
            
        }
        
        if K_Defaults.string(forKey: Saved.TOKEN) != nil {
            personalDetailsView.isHidden = false
        } else {
            personalDetailsView.isHidden = true
        }
    }
    
    
    
    private func navigateScreen(vc: UIViewController){
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func btnLogoutPressed(_ sender: UIButton){
        logout()
        K_Defaults.removeObject(forKey: Saved.TOKEN)
        K_Defaults.removeObject(forKey: Saved.PHONE_NUMBER)
        K_AppDelegate.redirectToHome()
    }
    
    func logout(){
        K_Network.sendRequest(function: apiService.logout(params: AddTokenInput(deviceToken: Saved.TOKEN)), success: { (code, msg, response)  in
            do {
                let _ = try response.map(to: User.self)
                
                
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
}
