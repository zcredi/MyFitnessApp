//
//  WeatherView.swift
//  MyFitnessApp
//
//  Created by Владислав on 20.02.2023.
//

import UIKit

class WeatherView: UIView {
    enum Constants {
        static let sunImageSize: CGFloat = 62.0
        static let sunImageTrailingSpacing: CGFloat = 10.0
        static let weatherStatusLabelSideSpacing: CGFloat = 10.0
        static let weatherStatusLabelHeightSize: CGFloat = 20.0
        static let weatherTextLabelTopSpacing: CGFloat = 5.0
        static let weatherTextLabelBottomSpacing: CGFloat = 5.0
        static let weatherTextLabelSideSpacing: CGFloat = 10.0
    }
    
    private lazy var sunImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sun")
        return imageView
    }()
    
    private lazy var weatherStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Солнечно"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
    private lazy var weatherTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Хорошая погода, чтобы позаниматься на улице"
        label.numberOfLines = 0
        label.textColor = .specialGrayTextColor
        label.font = .robotoMedium12()
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
            sunImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sunImageTrailingSpacing),
            sunImageView.heightAnchor.constraint(equalToConstant: Constants.sunImageSize),
            sunImageView.widthAnchor.constraint(equalToConstant: Constants.sunImageSize),
            sunImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        weatherStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherStatusLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.weatherStatusLabelSideSpacing),
            weatherStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.weatherStatusLabelSideSpacing),
            weatherStatusLabel.trailingAnchor.constraint(equalTo: sunImageView.leadingAnchor, constant: -Constants.weatherStatusLabelSideSpacing),
            weatherStatusLabel.heightAnchor.constraint(equalToConstant: Constants.weatherStatusLabelHeightSize)
        ])
        weatherTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherTextLabel.topAnchor.constraint(equalTo: weatherStatusLabel.bottomAnchor, constant: Constants.weatherTextLabelTopSpacing),
            weatherTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.weatherTextLabelSideSpacing),
            weatherTextLabel.trailingAnchor.constraint(equalTo: sunImageView.leadingAnchor, constant: -Constants.weatherTextLabelSideSpacing),
            weatherTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.weatherTextLabelBottomSpacing)
        ])
    }
}
