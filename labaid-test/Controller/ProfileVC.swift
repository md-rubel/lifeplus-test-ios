//
//  ProfileVC.swift
//  labaid-test
//
//  Created by MD RUBEL on 20/1/21.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
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
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        
        guard let token = UserDefaults.standard.value(forKey: Shared.USER_TOKEN) as? String else {
            return
        }
        
        ApiManager.shared.logoutWith(token: token) { [self] (success) in
            if success {
                UserDefaults.standard.setValue(false, forKey: Shared.LOGGED_IN_STATUS)
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
