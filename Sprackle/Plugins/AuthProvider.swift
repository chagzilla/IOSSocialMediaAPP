//
//  AuthProvider.swift
//  ChatApp
//
//  Created by Wilbert Chagula on 6/16/18.
//  Copyright © 2018 Wilbert Chagula. All rights reserved.
//

import Foundation
import FirebaseAuth


typealias LoginHandler = (_ msg: String?) -> Void;

struct LoginErrorCode {
    
    static let INVALID_EMAIL = "Invalid Email Address, Please Provide A Real Email Address";
    
    static let WRONG_PASSWORD = "Wrong Password, Please Enter the Correct Password";
    
    static let PROBLEM_CONNECTING = "Invalid Email Address, Please Provide A Real Email Address";
    
    static let USER_NOT_FOUND = "Invalid Email Address, Please Provide A Real Email Address";
    
    static let EMAIL_ALREADY_IN_USE = "Invalid Email Address, Please Provide A Real Email Address";
    
    static let WEAK_PASSWORD = "Invalid Email Address, Please Provide A Real Email Address";
    
    static let ERROR_UKNOWN = "The error is unknown";
}
    
    
    class AuthProvider {
        private static let _instance = AuthProvider();
    
        static var Instance: AuthProvider {
            return _instance;
        }
        
        var userName = ""
        
        func login(withEmail: String, password: String, loginHandler: LoginHandler?) {
            Auth.auth().signIn(withEmail: withEmail, password: password, completion: {(user, error) in
                
                if error != nil {
                    self.handleErrors(err:error! as NSError, loginHandler: loginHandler);
                } else {
                    loginHandler?(nil);
                }
            })
        }
        
        func signUp(withEmail: String, password: String, loginHandler: LoginHandler?, data: Dictionary<String, Any>) {
            
            Auth.auth().createUser(withEmail: withEmail, password: password, completion: { (user, error) in
                
                if error != nil {
                    self.handleErrors(err: error! as NSError,
                                      loginHandler: loginHandler);
                    
                } else {
                    if user != nil {
                        DBProvider.Instance.saveUser(withID: user!.user.uid, data:data)
                        self.login(withEmail: withEmail, password: password, loginHandler: loginHandler)
                    }
                }
            }
            );
        }
        
        func signOut() {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
        
        func userID() -> String {
            return Auth.auth().currentUser!.uid;
        }
        
        private func handleErrors(err: NSError, loginHandler: LoginHandler?) {
            
            if let errCode = AuthErrorCode(rawValue: err.code) {
                switch errCode {
                case .wrongPassword:
                    loginHandler?(LoginErrorCode.WRONG_PASSWORD);
                    break;
                case .invalidEmail:
                    loginHandler?(LoginErrorCode.INVALID_EMAIL);
                    break;
                case .userNotFound:
                    loginHandler?(LoginErrorCode.USER_NOT_FOUND);
                    break;
                case .emailAlreadyInUse:
                    loginHandler?(LoginErrorCode.EMAIL_ALREADY_IN_USE);
                    break;
                case .weakPassword:
                    loginHandler?(LoginErrorCode.WEAK_PASSWORD);
                    break;
                default:
                    loginHandler?(LoginErrorCode.ERROR_UKNOWN);
                }
            }
        }
        
    }

