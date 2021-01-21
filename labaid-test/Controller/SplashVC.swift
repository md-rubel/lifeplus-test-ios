//
//  SplashVC.swift
//  labaid-test
//
//  Created by MD RUBEL on 20/1/21.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sleep(1)
        
        if UserDefaults.standard.bool(forKey: Shared.LOGGED_IN_STATUS) {
            guard let homeVC = storyboard?.instantiateViewController(withIdentifier: "DashboardVC") else { return }
            navigationController?.pushViewController(homeVC, animated: true)
            
        } else {
            performSegue(withIdentifier: "OpenLoginVC", sender: self)
        }
    }
}
