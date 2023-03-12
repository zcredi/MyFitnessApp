//
//  DateAndRepeatView.swift
//  MyFirstApp_20.02.
//
//  Created by Владислав on 02.03.2023.
//

import UIKit

class DateAndRepeatView: UIView {
    enum Constants {
        static let dateAndRepeatLabelTopSpacing: CGFloat = 0.0
        static let dateAndRepeatLabelSideSpacing: CGFloat = 7.0
        static let dateAndRepeatLabelHeightSpacing: CGFloat = 16.0
        static let backViewTopSpacing: CGFloat = 1.0
        static let backViewSideSpacing: CGFloat = 0.0
        static let backViewBottomSpacing: CGFloat = 0.0
        static let dateStackViewTopSpacing: CGFloat = 10.0
        static let dateStackViewSideSpacing: CGFloat = 10.0
        static let repeatStackViewTopSpacing: CGFloat = 13.0
        static let repeatStackViewSideSpacing: CGFloat = 10.0
    }
    
    //MARK: - Create UI
    
    private lazy var dateAndRepeatLabel = UILabel(text: "Date and repeat")
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBrown
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var dateLabel = UILabel(text: "Date", font: .robotoMedium18(), textColor: .specialGray)
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.tintColor = .specialGray
        return datePicker
    }()
    
    private lazy var repeatEveryLabel = UILabel(text: "Repeat every 7 days", font: .robotoMedium18(), textColor: .specialGray)
    
    private lazy var repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.onTintColor = .specialGreen
        return repeatSwitch
    }()
    
    private lazy var dateStackView = UIStackView()
    private lazy var repeatStackView = UIStackView()
    
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
        addSubview(dateAndRepeatLabel)
        addSubview(backView)
        
        dateStackView = UIStackView(arrangedSubviews: [dateLabel, datePicker], axis: .horizontal, spacing: 10)
        dateStackView.distribution = .equalSpacing
        
        backView.addSubview(dateStackView)
        
        repeatStackView = UIStackView(arrangedSubviews: [repeatEveryLabel, repeatSwitch], axis: .horizontal, spacing: 10)
        repeatStackView.distribution = .equalSpacing
        
        backView.addSubview(repeatStackView)
    }
    
    public func getDateAndRepeat() -> (date: Date, isRepeat: Bool) {
        (datePicker.date, repeatSwitch.isOn)
    }
}

//MARK: - setConstraints()

extension DateAndRepeatView {
    private func setConstraints() {
        dateAndRepeatLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateAndRepeatLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.dateAndRepeatLabelTopSpacing),
            dateAndRepeatLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.dateAndRepeatLabelSideSpacing),
            dateAndRepeatLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.dateAndRepeatLabelSideSpacing),
            dateAndRepeatLabel.heightAnchor.constraint(equalToConstant: Constants.dateAndRepeatLabelHeightSpacing)
        ])
        backView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: dateAndRepeatLabel.bottomAnchor, constant: Constants.backViewTopSpacing),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.backViewSideSpacing),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.backViewSideSpacing),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.backViewBottomSpacing)
        ])
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: Constants.dateStackViewTopSpacing),
            dateStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: Constants.dateStackViewSideSpacing),
            dateStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -Constants.dateStackViewSideSpacing)
        ])
        repeatStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            repeatStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: Constants.repeatStackViewTopSpacing),
            repeatStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.repeatStackViewSideSpacing),
            repeatStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.repeatStackViewSideSpacing)
        ])
    }
}
