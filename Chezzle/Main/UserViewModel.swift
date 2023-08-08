//
//  LoginViewModel.swift
//  Chezzle
//
//  Created by Jakob Peter on 05.06.23.
//
import Firebase
import Foundation

class UserViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var isVerified = false
    @Published var usrId: Int? = nil
    
    @Published var usrMail: String = ""
    @Published var usrPswd: String = ""
    
    @Published var showAlert = false
    @Published var alertText = ""
    
    @Published var rememberUser = false
    
    
    private var auth = Auth.auth()
    
    init(isLoggedIn: Bool = false, usrId: Int? = nil) {
        self.isLoggedIn = isLoggedIn
        self.usrId = usrId
        let df = UserDefaults()
        
        guard let loginState = df.object(forKey: "isLoggedIn") as? Bool else {
            print("no defaults found")
            return
        }
        
        self.rememberUser = loginState
        
        if(loginState){
            print("Login with defaults")
            self.usrMail = df.object(forKey: "email") as! String
            self.usrPswd = df.object(forKey: "pswd") as! String
            signIn()
            self.isLoggedIn = true
        }
        
    }
    
    func signUp() {
        auth.createUser(withEmail: usrMail, password: usrPswd) {result, error in
            if error != nil {
                self.alertText = error!.localizedDescription
                self.showAlert = true
                self.isLoggedIn = false
                
            } else {
                self.sendVerificationEmail()
                
            }
        }
    }
  
    func createUser(with id: String) async {
        Task {
            do {
                try await Database.shared.createUser(with: id)
            } catch {
                print("User not Created")
            }
        }
    }
        
    func signIn() {
        
        self.auth.signIn(withEmail: self.usrMail, password: self.usrPswd) {result, error in
            if error != nil {
                
                let code = Firebase.AuthErrorCode(_nsError: error! as NSError).code
                
                if code == Firebase.AuthErrorCode.userNotFound {
                    self.signUp()
                }
                else {
                    self.alertText = error!.localizedDescription
                    self.showAlert = true
                    self.isLoggedIn = false
                    
                }
                
            } else {
                
                if self.auth.currentUser!.isEmailVerified {
                    self.rememberUser(bool: self.rememberUser)
                    self.isLoggedIn = true
                }
                else {
                    self.isLoggedIn = false
                    self.sendVerificationEmail()
                    
                }
                
            }
        }
        
        
    }
    
    func rememberUser(bool: Bool) {
        UserDefaults.standard.set(bool ? true: false, forKey:  "isLoggedIn")
        if bool {
            UserDefaults.standard.set(self.usrMail,forKey: "email")
            UserDefaults.standard.set(self.usrPswd,forKey: "pswd")
        }
        
    }
    
    func sendVerificationEmail(){
        if self.auth.currentUser != nil {
            
            self.auth.currentUser?.sendEmailVerification{ error in
                if error != nil {
                    self.alertText = error!.localizedDescription
                    self.showAlert = true
                }
                self.alertText = "Please follow the link in the email we've sent you"
                self.showAlert = true
            }
            
        }
    }
    
    func logOut() {
        do {
            try auth.signOut()
            self.isLoggedIn = false
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
        }
        catch {
            self.alertText = "Logout failed"
            self.showAlert = true
        }
    }
    
}
