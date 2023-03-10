//
//  RepsOrTimerView.swift
//  MyFirstApp_20.02.
//
//  Created by Владислав on 02.03.2023.
//

import UIKit

class RepsOrTimerView: UIView {
    enum Constants {
        static let repsOrTimerLabelTopSpacing: CGFloat = 0.0
        static let repsOrTimerLabelSideSpacing: CGFloat = 7.0
        static let repsOrTimerLabelHeightSpacing: CGFloat = 16.0
        static let backViewTopSpacing: CGFloat = 1.0
        static let backViewSideSpacing: CGFloat = 0.0
        static let backViewBottomSpacing: CGFloat = 0.0
        static let sliderStackViewTopSpacing: CGFloat = 10.0
        static let sliderStackViewSideSpacing: CGFloat = 14.0
    }
    
    //MARK: - Create UI
    
    private lazy var repsOrTimerLabel = UILabel(text: "Reps or timer")
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBrown
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var setsView = SliderView(name: "Sets", minValue: 0, maxValue: 10, type: .sets)
    
    private lazy var repeatOrTimerLabel = UILabel(text: "Choose repeat or timer")
    private lazy var repsView = SliderView(name: "Reps", minValue: 0, maxValue: 50, type: .reps)
    private lazy var timerView = SliderView(name: "Timer", minValue: 0, maxValue: 600, type: .timer)
    
    private lazy var sliderStackView = UIStackView()
    
    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegates() {
        setsView.delegate = self
        repsView.delegate = self
        timerView.delegate = self
    }
    
    private func setupViews() {
        repeatOrTimerLabel.textAlignment = .center
        
        addSubview(repsOrTimerLabel)
        
        addSubview(backView)
        sliderStackView = UIStackView(arrangedSubviews: [setsView, repeatOrTimerLabel, repsView, timerView], axis: .vertical, spacing: 10)
        backView.addSubview(sliderStackView)
    }
}

//MARK: - SliderViewProtocol

extension RepsOrTimerView: SliderViewProtocol {
    func changeValue(type: SliderType, value: Int) {
        switch type {
        case .sets:
            sets = value
        case .reps:
            reps = value
            repsView.isActive = true
            timerView.isActive = false
            timer = 0
        case .timer:
            timer = value
            repsView.isActive = false
            timerView.isActive = true
            reps = 0
        }
    }
    
    
}

//MARK: - setConstraints()

extension RepsOrTimerView {
    private func setConstraints() {
        repsOrTimerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            repsOrTimerLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.repsOrTimerLabelTopSpacing),
            repsOrTimerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.repsOrTimerLabelSideSpacing),
            repsOrTimerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.repsOrTimerLabelSideSpacing),
            repsOrTimerLabel.heightAnchor.constraint(equalToConstant: Constants.repsOrTimerLabelHeightSpacing)
        ])
        backView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: repsOrTimerLabel.bottomAnchor, constant: Constants.backViewTopSpacing),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.backViewSideSpacing),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.backViewSideSpacing),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.backViewBottomSpacing)
        ])
        sliderStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderStackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: Constants.sliderStackViewTopSpacing),
            sliderStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: Constants.sliderStackViewSideSpacing),
            sliderStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -Constants.sliderStackViewSideSpacing)
        ])
    }
}
