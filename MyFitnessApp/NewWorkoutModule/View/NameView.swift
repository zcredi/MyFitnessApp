//
//  NameView.swift
//  MyFirstApp_20.02.
//
//  Created by Владислав on 02.03.2023.
//

import UIKit

class NameView: UIView {
    enum Constants {
        static let nameLabelTopSpacing: CGFloat = 0.0
        static let nameLabelSideSpacing: CGFloat = 7.0
        static let nameLabelHeightSpacing: CGFloat = 16.0
        static let nameTextFildTopSpacing: CGFloat = 3.0
        static let nameTextFildSideSpacing: CGFloat = 0.0
        static let nameTextFildBottomSpacing: CGFloat = 3.0
    }

    //MARK: - Create UI
    
    private lazy var nameLabel = UILabel(text: "Name")
    private lazy var nameTextFild = BrownTextField()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(nameLabel)
        addSubview(nameTextFild)
    }
    
    public func getNameTextFieldText() -> String {
        guard let text = nameTextFild.text else { return "" }
        return text
    }
}

extension NameView {
    private func setConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.nameLabelTopSpacing),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.nameLabelSideSpacing),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.nameLabelSideSpacing),
            nameLabel.heightAnchor.constraint(equalToConstant: Constants.nameLabelHeightSpacing)
        ])
        nameTextFild.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextFild.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.nameTextFildTopSpacing),
            nameTextFild.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.nameTextFildSideSpacing),
            nameTextFild.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.nameTextFildSideSpacing),
            nameTextFild.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.nameTextFildBottomSpacing)
        ])
    }
}
