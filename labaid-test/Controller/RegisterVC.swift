//
//  RegisterVC.swift
//  labaid-test
//
//  Created by MD RUBEL on 20/1/21.
//

import UIKit
import JGProgressHUD

class RegisterVC: UIViewController {
    
    @IBOutlet weak var nameTF: CustomTF!
    @IBOutlet weak var emailTF: CustomTF!
    @IBOutlet weak var passwordTF: CustomTF!
    @IBOutlet weak var phoneTF: CustomTF!
    @IBOutlet weak var backButton: UIButton!
    
    private let hud = JGProgressHUD(style: .dark)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.setImage(#imageLiteral(resourceName: "arrow_back").withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func saveLocalUser(with userModel: UserModel) {
        UserDefaults.standard.setValue(userModel.token, forKey: Shared.USER_TOKEN)
        UserDefaults.standard.setValue(userModel.user.name, forKey: Shared.USER_NAME)
        UserDefaults.standard.setValue(userModel.user.email, forKey: Shared.USER_EMAIL)
        UserDefaults.standard.setValue(userModel.user.phone, forKey: Shared.USER_PHONE)
        UserDefaults.standard.setValue(true, forKey: Shared.LOGGED_IN_STATUS)
    }
    
    @IBAction func registerButtonPressed(_ sender: CustomButton) {
        
        guard let name = nameTF.text,
              let email = emailTF.text,
              let password = passwordTF.text,
              let phone = phoneTF.text,
              !name.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              !phone.isEmpty
        else {
            
            let alert = UIAlertController(title: "Warning!", message: "All the fields are required. Please fill the form carefully.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        hud.show(in: view)
        
        ApiManager.shared.registerWith(name: name, email: email, password: password, phone: phone) { [self] (user) in
            if let user = user {
                saveLocalUser(with: user)
                
                DispatchQueue.main.async {
                    hud.dismiss()
                    
                    guard let homeVC = storyboard?.instantiateViewController(withIdentifier: "DashboardVC") else { return }
                    navigationController?.pushViewController(homeVC, animated: true)
                }
                
            } else {
                DispatchQueue.main.async {
                    hud.dismiss()
                    
                    let alert = UIAlertController(title: "Failed!", message: "There is something wrong. It might there is already a user with the email you provided. Plase try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
