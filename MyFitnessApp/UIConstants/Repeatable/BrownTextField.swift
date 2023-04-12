//
//  BrownTextField.swift
//  MyFirstApp_20.02.
//
//  Created by Владислав on 06.03.2023.
//

import UIKit

class BrownTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
       backgroundColor = .specialBrown
       layer.cornerRadius = 10
       textColor = .specialGray
       font = .robotoBold20()
       borderStyle = .none
       leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
       leftViewMode = .always
       clearButtonMode = .always
       returnKeyType = .done
    }
}

//MARK: - UITextFieldDelegate

extension BrownTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
