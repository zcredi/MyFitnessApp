//
//  GreenButton.swift
//  MyFirstApp_20.02.
//
//  Created by Владислав on 06.03.2023.
//

import UIKit

class GreenButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text: String) {
        self.init(type: .system)
        setTitle(text, for: .normal)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .specialGreen
        tintColor = .white
        titleLabel?.font = .robotoBold16()
        layer.cornerRadius = 10
    }
}
