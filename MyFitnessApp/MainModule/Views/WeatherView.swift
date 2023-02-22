//
//  WeatherView.swift
//  MyFitnessApp
//
//  Created by Владислав on 20.02.2023.
//

import UIKit

class WeatherView: UIView {
    enum Constants {
        
    }
    
    private lazy var sunImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sun")
        return imageView
    }()
    
    private lazy var weatherStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Солнечно"
        label.textColor = .basicTextColor
        label.font = UIFont(name: UIFont.robotoMedium, size: 18)
        return label
    }()
    
    private lazy var weatherTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Хорошая погода, чтобы позаниматься на улице"
        label.numberOfLines = 0
        label.textColor = .grayBackgroundColor
        label.font = UIFont(name: UIFont.robotoMedium, size: 13)
        return label
    }()
    
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
        backgroundColor = .white
        layer.cornerRadius = 10
        addSubview(sunImageView)
        addSubview(weatherStatusLabel)
        addSubview(weatherTextLabel)
    }
}

extension WeatherView {
    private func setConstraints() {
        sunImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sunImageView.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            sunImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            sunImageView.heightAnchor.constraint(equalToConstant: 62),
            sunImageView.widthAnchor.constraint(equalToConstant: 62)
        ])
        weatherStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherStatusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
        weatherTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherTextLabel.topAnchor.constraint(equalTo: weatherStatusLabel.bottomAnchor, constant: 5),
            weatherTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherTextLabel.trailingAnchor.constraint(equalTo: sunImageView.leadingAnchor, constant: -16)
        ])
    }
}
