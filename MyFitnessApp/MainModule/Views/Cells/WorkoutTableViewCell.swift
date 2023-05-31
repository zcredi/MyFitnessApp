//
//  WorkoutTableViewCell.swift
//  MyFirstApp_20.02.
//
//  Created by Владислав on 27.02.2023.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    enum Constants {
        static let backgroundCellTopSpacing: CGFloat = 5.0
        static let backgroundCellSideSpacing: CGFloat = 10.0
        static let workoutBackgroundViewLeadingSpacing: CGFloat = 8.0
        static let workoutBackgroundViewSize: CGFloat = 78.0
        static let workoutImageViewSideSpacing: CGFloat = 10.0
        static let workoutNameLabelTopSpacing: CGFloat = 10.0
        static let workoutNameLabelSpacing: CGFloat = 10.0
        static let lablesStackViewTopSpacing: CGFloat = 0.0
        static let lablesStackViewSideSpacing: CGFloat = 10.0
        static let startButtonTopSpacing: CGFloat = 3.0
        static let startButtonSideSpacing: CGFloat = 10.0
        static let startButtonHeightSize: CGFloat = 30.0
    }
    
    private lazy var backgroundCell: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBrown
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var workoutBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var workoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "testWorkout")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var workoutNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull Ups"
        label.textColor = .specialBlack
        label.font = .robotoMedium22()
        return label
    }()
    
    private lazy var workoutRepsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps: 10"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        return label
    }()
    
    private lazy var workoutSetsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets: 2"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.addShadowOnView()
        button.titleLabel?.font = .robotoBold16()
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                startButton.setTitle("COMPLETE", for: .normal)
                startButton.tintColor = .white
                startButton.backgroundColor = .specialDarkGreen
                startButton.isEnabled = false
            } else {
                startButton.setTitle("START", for: .normal)
                startButton.tintColor = .specialDarkGreen
                startButton.backgroundColor = .specialYellow
                startButton.isEnabled = true
            }
        }
    }
    
    private lazy var labelsStackView = UIStackView()
    
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(backgroundCell)
        addSubview(workoutBackgroundView)
        workoutBackgroundView.addSubview(workoutImageView)
        addSubview(workoutNameLabel)
        labelsStackView = UIStackView(arrangedSubviews: [workoutRepsLabel, workoutSetsLabel],
                                      axis: .horizontal,
                                      spacing: 10)
        addSubview(labelsStackView)
        contentView.addSubview(startButton)
    }
    
    @objc
    private func startButtonTapped() {
        print("Tapped StartButton")
    }
    
    public func configure(model: WorkoutModel) {
        workoutNameLabel.text = model.workoutName
        
        if model.workoutTimer == 0 {
            workoutRepsLabel.text = "Reps: \(model.workoutReps)"
        } else {
            workoutRepsLabel.text = "Timer: \(model.workoutTimer.getTimeFromSeconds())"
        }
        
        workoutSetsLabel.text = "Sets: \(model.workoutSets)"
        
        isSelected = model.workoutStatus
        
        guard let imageData = model.workoutImage,
              let image = UIImage(data: imageData) else { return }
        
        workoutImageView.image = image.withRenderingMode(.alwaysTemplate)
        
    }
    
}

//MARK: - setConstraints()

extension WorkoutTableViewCell {
    private func setConstraints() {
        backgroundCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: Constants.backgroundCellTopSpacing),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.backgroundCellSideSpacing),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.backgroundCellSideSpacing),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        workoutBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workoutBackgroundView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            workoutBackgroundView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: Constants.workoutBackgroundViewLeadingSpacing),
            workoutBackgroundView.heightAnchor.constraint(equalToConstant: Constants.workoutBackgroundViewSize),
            workoutBackgroundView.widthAnchor.constraint(equalToConstant: Constants.workoutBackgroundViewSize)
        ])
        workoutImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workoutImageView.topAnchor.constraint(equalTo: workoutBackgroundView.topAnchor, constant: Constants.workoutImageViewSideSpacing),
            workoutImageView.leadingAnchor.constraint(equalTo: workoutBackgroundView.leadingAnchor, constant: Constants.workoutImageViewSideSpacing),
            workoutImageView.trailingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: -Constants.workoutImageViewSideSpacing),
            workoutImageView.bottomAnchor.constraint(equalTo: workoutBackgroundView.bottomAnchor, constant: -Constants.workoutImageViewSideSpacing),
        ])
        workoutNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workoutNameLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: Constants.workoutNameLabelTopSpacing),
            workoutNameLabel.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: Constants.workoutNameLabelSpacing),
            workoutNameLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -Constants.workoutNameLabelSpacing)
        ])
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: Constants.lablesStackViewTopSpacing),
            labelsStackView.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: Constants.lablesStackViewSideSpacing),
            labelsStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: Constants.startButtonTopSpacing),
            startButton.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: Constants.startButtonSideSpacing),
            startButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -Constants.startButtonSideSpacing),
            startButton.heightAnchor.constraint(equalToConstant: Constants.startButtonHeightSize)
        ])
    }
}
