//
//  AuthManager.swift
//  CurePlus
//
//  Created by mac on 23/11/2023.
//

import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    let auth = Auth.auth()
    var verificationId: String?
    
    public func startAuth(phoneumber: String , completion: @escaping (Bool) -> Void){
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneumber, uiDelegate: nil){ verificationId , error in
            guard let verificationId = verificationId , error == nil else {
                completion(false)
                return}
            self.verificationId = verificationId
            completion(true)
        }
    }
    
    
    
    public func verifyCode(smsCode: String , completion: @escaping (Bool) -> Void){
        guard let verificationId = verificationId else {
            completion(false)
            return
        }
        
        let credntial = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: smsCode)
        auth.signIn(with: credntial) { result, error in
            guard result != nil  , error == nil else{
                completion(false)
                return
            }
            completion(true)
        }
    }
}
