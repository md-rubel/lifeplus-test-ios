//
//  CustomTF.swift
//  labaid-test
//
//  Created by MD RUBEL on 20/1/21.
//

import UIKit

class CustomTF: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 98/255,
                                    green: 188/255,
                                    blue: 72/255,
                                    alpha: 1.0).cgColor
        
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        leftViewMode = .always
    }
}
