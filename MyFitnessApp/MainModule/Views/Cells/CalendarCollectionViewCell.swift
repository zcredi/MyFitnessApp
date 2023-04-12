//
//  CalendarCollectionViewCell.swift
//  MyFirstApp_20.02.
//
//  Created by Владислав on 23.02.2023.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    enum Constants {
        static let dayOfWeekLabelTopSpacing: CGFloat = 10.0
        static let numberOfDayLabelBottomSpacing: CGFloat = 4.0
    }
    
    private lazy var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.text = "We"
        label.font = .robotoBold16()
        label.textColor = .white
        return label
    }()
    
    private lazy var numberOfDayLabel: UILabel = {
        let label = UILabel()
        label.text = "23"
        label.font = .robotoBold20()
        label.textColor = .white
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                backgroundColor = .specialYellow
                dayOfWeekLabel.textColor = .specialBlackTextColor
                numberOfDayLabel.textColor = .specialGreenTextColor
            } else {
                backgroundColor = .clear
                dayOfWeekLabel.textColor = .white
                numberOfDayLabel.textColor = .white
            }
        }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(dayOfWeekLabel)
        addSubview(numberOfDayLabel)
    }
    
    public func dateForCell(numberOfDay: String, dayOfWeek: String) {
        dayOfWeekLabel.text = dayOfWeek
        numberOfDayLabel.text = numberOfDay
    }
}

//MARK: - setConstraints()

extension CalendarCollectionViewCell {
    private func setConstraints() {
        dayOfWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayOfWeekLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.dayOfWeekLabelTopSpacing),
            dayOfWeekLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        numberOfDayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberOfDayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.numberOfDayLabelBottomSpacing),
            numberOfDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
