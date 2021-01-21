//
//  DashboardVC.swift
//  labaid-test
//
//  Created by MD RUBEL on 20/1/21.
//

import UIKit
import JGProgressHUD

class DashboardVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    private let hud = JGProgressHUD(style: .dark)
    private var searchResult = [SearchModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "OpenProfileVC", sender: self)
    }
}

extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imgUrl = searchResult[indexPath.row].image.medium
        
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = searchResult[indexPath.row].name
        
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.sd_setImage(with: URL(string: imgUrl), placeholderImage: #imageLiteral(resourceName: "icon"))
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let resultVC = storyboard?.instantiateViewController(withIdentifier: "ResultVC") as? ResultVC else { return }
        resultVC.searchModel = searchResult[indexPath.row]
        
        navigationController?.pushViewController(resultVC, animated: true)
    }
}

extension DashboardVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchResult.removeAll()
            updateUI()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }

        searchBar.resignFirstResponder()

        searchResult.removeAll()
        hud.show(in: view)
        
        ApiManager.shared.search(for: text) { [self] (results) in
            if let result = results {
                searchResult.append(result)
            }
            
            DispatchQueue.main.async {
                hud.dismiss()
                updateUI()
            }
        }
    }
    
    private func updateUI() {
        if searchResult.isEmpty {
            noResultsLabel.isHidden = false
            tableView.isHidden = true
            
        } else {
            noResultsLabel.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
}
