//
//  AppDelegate.swift
//  Luxcar
//
//  Created by mac on 13/09/2023.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseCore
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var vc: UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        UIApplication.shared.statusBarStyle = .lightContent

        setupKeyboardManager()
        redirectToHome()
        if K_Defaults.bool(forKey: Saved.IS_LISTED) == nil {
            K_Defaults.setValue(true, forKey: Saved.IS_LISTED)
        }
        GMSServices.provideAPIKey("AIzaSyDbU50Ek4kW8rS35PyLCz9nN6gzbNNlik8")
        FirebaseApp.configure()
        return true
    }
    
    public func redirectToHome() {
        if K_Defaults.string(forKey: Saved.TOKEN) != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: "tabController")
        }else{
            vc = LoginVC.loadFromNib()
        }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
    
    private func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarConfiguration.placeholderConfiguration.showPlaceholder = false
        IQKeyboardManager.shared.toolbarConfiguration.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.toolbarConfiguration.placeholderConfiguration.showPlaceholder = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        guard let url = userActivity.webpageURL else { return false}
        let type = url.pathComponents[1]
        let id = url.pathComponents[2]
        guard let topViewController = UIApplication.topViewController() else { return false}
        return true
    }

}

extension AppDelegate {
    
    func configureApp(_ application: UIApplication) {
        configAppSetting()
        configureAppAppearance()
        configureIQKeyboardAppearance()
        application.applicationIconBadgeNumber = 0
    }
    
    func configureIQKeyboardAppearance() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.playInputClicks = false
        IQKeyboardManager.shared.resignOnTouchOutside = false
        IQKeyboardManager.shared.toolbarConfiguration.previousNextDisplayMode = .alwaysHide
    }
    
    func configureAppAppearance() {
        DispatchQueue.main.async {
            self.window?.overrideUserInterfaceStyle = .light
        }
    }
    
    func configAppSetting() {
        configureAppAppearance()
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
    }
}

