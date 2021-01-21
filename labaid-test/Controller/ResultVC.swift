//
//  ResultVC.swift
//  labaid-test
//
//  Created by MD RUBEL on 20/1/21.
//

import UIKit
import SDWebImage

class ResultVC: UIViewController {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var premieredLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var searchModel: SearchModel?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }
    
    private func setupUI() {
        
        backButton.setImage(#imageLiteral(resourceName: "arrow_back").withRenderingMode(.alwaysTemplate), for: .normal)
        
        guard let searchModel = searchModel else {
            nameLabel.text = nil
            typeLabel.text = nil
            languageLabel.text = nil
            genreLabel.text = nil
            premieredLabel.text = nil
            summaryLabel.text = nil
            
            return
        }
        
        bannerImageView.sd_setImage(with: URL(string: searchModel.image.medium), completed: nil)
        
        nameLabel.text = searchModel.name
        typeLabel.text = "Type: \(searchModel.type)"
        languageLabel.text = "Language: \(searchModel.language)"
        
        premieredLabel.text = "Premiered: \(searchModel.premiered)"
        
        if !searchModel.genres.isEmpty {
            genreLabel.text = "Genre: \(searchModel.genres[0])"
        }
        
        var summary = searchModel.summary.replacingOccurrences(of: "<p>", with: "")
        summary = summary.replacingOccurrences(of: "</p>", with: "")
        summary = summary.replacingOccurrences(of: "<b>", with: "")
        summary = summary.replacingOccurrences(of: "</b>", with: "")
        summary = summary.replacingOccurrences(of: "<i>", with: "")
        summary = summary.replacingOccurrences(of: "</i>", with: "")
        
        summaryLabel.text = "Summary: \(summary)"
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
