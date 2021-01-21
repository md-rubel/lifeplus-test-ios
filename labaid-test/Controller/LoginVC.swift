//
//  LoginVC.swift
//  labaid-test
//
//  Created by MD RUBEL on 20/1/21.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTF: CustomTF!
    @IBOutlet weak var passwordTF: CustomTF!
    
    private func saveLocalUser(with userModel: UserModel) {
        UserDefaults.standard.setValue(userModel.token, forKey: Shared.USER_TOKEN)
        UserDefaults.standard.setValue(userModel.user.name, forKey: Shared.USER_NAME)
        UserDefaults.standard.setValue(userModel.user.email, forKey: Shared.USER_EMAIL)
        UserDefaults.standard.setValue(userModel.user.phone, forKey: Shared.USER_PHONE)
        UserDefaults.standard.setValue(true, forKey: Shared.LOGGED_IN_STATUS)
    }
    
    @IBAction func loginButtonPressed(_ sender: CustomButton) {
        
        guard let email = emailTF.text,
              let password = passwordTF.text,
              !email.isEmpty,
              !password.isEmpty
        else {
            
            let alert = UIAlertController(title: "Warning!", message: "All the fields are required. Please fill the form carefully.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        ApiManager.shared.loginWith(email: email, password: password) { [self] (user) in
            if let user = user {
                saveLocalUser(with: user)
                
                DispatchQueue.main.async {
                    guard let homeVC = storyboard?.instantiateViewController(withIdentifier: "DashboardVC") else { return }
                    navigationController?.pushViewController(homeVC, animated: true)
                }
                
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Failed!", message: "Either email or password or both are wrong. Please try again with correct credential.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func newAccountButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "OpenRegisterVC", sender: self)
    }
}
