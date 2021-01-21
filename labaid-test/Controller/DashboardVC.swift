//
//  DashboardVC.swift
//  labaid-test
//
//  Created by MD RUBEL on 20/1/21.
//

import UIKit

class DashboardVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "OpenProfileVC", sender: self)
    }
}
