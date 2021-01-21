//
//  ProfileVC.swift
//  labaid-test
//
//  Created by MD RUBEL on 20/1/21.
//

import UIKit
import JGProgressHUD

class ProfileVC: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    private let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData()
    }
    
    private func setupUI() {
        backButton.setImage(#imageLiteral(resourceName: "arrow_back").withRenderingMode(.alwaysTemplate), for: .normal)
        
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(red: 98/255,
                                                  green: 188/255,
                                                  blue: 72/255,
                                                  alpha: 1.0).cgColor
        
        nameLabel.text = nil
        emailLabel.text = nil
        phoneLabel.text = nil
    }
    
    private func getData() {
        guard let name = UserDefaults.standard.value(forKey: Shared.USER_NAME) as? String,
              let email = UserDefaults.standard.value(forKey: Shared.USER_EMAIL) as? String,
              let phone = UserDefaults.standard.value(forKey: Shared.USER_PHONE) as? String
        else {
            return
        }
        
        nameLabel.text = name
        emailLabel.text = email
        phoneLabel.text = phone
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        
        guard let token = UserDefaults.standard.value(forKey: Shared.USER_TOKEN) as? String else {
            return
        }
        
        hud.show(in: view)
        
        ApiManager.shared.logoutWith(token: token) { [self] (success) in
            if success {
                UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                UserDefaults.standard.synchronize()
                
                DispatchQueue.main.async {
                    hud.dismiss()
                    navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
}
