//
//  SliderView.swift
//  MyFirstApp_20.02.
//
//  Created by Владислав on 06.03.2023.
//

import UIKit

class SliderView: UIView {
    enum Constants {
        static let stackViewTopSpacing: CGFloat = 0.0
        static let stackViewSideSpacing: CGFloat = 0.0
        static let stackViewBottomSpacing: CGFloat = 0.0
    }
    
    //MARK: - Create UI
    
    private lazy var nameLabel = UILabel(text: "Name", font: .robotoMedium18(), textColor: .specialGray)
    
    private lazy var numberLabel = UILabel(text: "0", font: .robotoMedium24(), textColor: .specialGray)
    
    private lazy var slider = GreenSlider()
    
    private lazy var stackView = UIStackView()
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    convenience init(name: String, minValue: Float, maxValue: Float) {
        self.init(frame: .zero)
        nameLabel.text = name
        slider.minimumValue = minValue
        slider.maximumValue = maxValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, numberLabel], axis: .horizontal, spacing: 10)
        labelsStackView.distribution = .equalSpacing
        
        stackView = UIStackView(arrangedSubviews: [labelsStackView, slider], axis: .vertical, spacing: 10)
        addSubview(stackView)
    }
}

extension SliderView {
    private func setConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.stackViewTopSpacing),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.stackViewSideSpacing),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.stackViewSideSpacing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.stackViewBottomSpacing)
        ])
    }
}
