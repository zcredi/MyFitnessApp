//
//  ViewController.swift
//  MyFirstApp_20.02.
//
//  Created by Владислав on 01.03.2023.
//

import UIKit

class NewWorkoutModuleViewController: UIViewController {
    enum Constants {
        static let newWorkoutLabelTopSpacing: CGFloat = 10.0
        static let closeButtonTrailingSpacing: CGFloat = 22.0
        static let closeButtonzSizeSpacing: CGFloat = 30.0
        static let nameViewHeightSpacing: CGFloat = 60.0
        static let dateAndRepeatViewHeightSpacing: CGFloat = 115.0
        static let repsOrTimerViewHeightSpacing: CGFloat = 310.0
        static let slidersStackViewTopSpacing: CGFloat = 10.0
        static let slidersStackViewSideSpacing: CGFloat = 22.0
        static let saveButtonTopSpacing: CGFloat = 25.0
        static let saveButtonSideSpacing: CGFloat = 22.0
        static let saveButtonHeightSpacing: CGFloat = 55
    }
    
    //MARK: - Create UI
    
    private lazy var newWorkoutLabel = UILabel(text: "NEW WORKOUT", font: .robotoMedium24(), textColor: .specialGray)
    
    private lazy var closeButton = CloseButton(type: .system)
    
    private lazy var nameView = NameView()
    private lazy var dateAndRepeatView = DateAndRepeatView()
    private lazy var repsOrTimerView = RepsOrTimerView()
    
    private lazy var slidersStackView = UIStackView()
    
    private lazy var saveButton = GreenButton(text: "SAVE")
    
    private lazy var workoutModel = WorkoutModel()
    private lazy var workoutImage = UIImage(named: "testWorkout")
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(newWorkoutLabel)
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        slidersStackView = UIStackView(arrangedSubviews: [nameView, dateAndRepeatView, repsOrTimerView], axis: .vertical, spacing: 30)
        view.addSubview(slidersStackView)
        
        view.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func saveButtonTapped() {
        dismiss(animated: true)
        setModel()
        print(workoutModel)
    }
    
    private func setModel() {
        workoutModel.workoutName = nameView.getNameTextFieldText()
        workoutModel.workoutDate = dateAndRepeatView.getDateAndRepeat().date
        workoutModel.workoutRepeat = dateAndRepeatView.getDateAndRepeat().isRepeat
        workoutModel.workoutSets = repsOrTimerView.sets
        workoutModel.workoutReps = repsOrTimerView.reps
        workoutModel.workoutTimer = repsOrTimerView.timer
        
    }
}

//MARK: - setConstraints()

extension NewWorkoutModuleViewController {
    private func setConstraints() {
        newWorkoutLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.newWorkoutLabelTopSpacing),
            newWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: newWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.closeButtonTrailingSpacing),
            closeButton.heightAnchor.constraint(equalToConstant: Constants.closeButtonzSizeSpacing),
            closeButton.widthAnchor.constraint(equalToConstant: Constants.closeButtonzSizeSpacing)
        ])
        nameView.translatesAutoresizingMaskIntoConstraints = false
        dateAndRepeatView.translatesAutoresizingMaskIntoConstraints = false
        repsOrTimerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameView.heightAnchor.constraint(equalToConstant: Constants.nameViewHeightSpacing),
            dateAndRepeatView.heightAnchor.constraint(equalToConstant: Constants.dateAndRepeatViewHeightSpacing),
            repsOrTimerView.heightAnchor.constraint(equalToConstant: Constants.repsOrTimerViewHeightSpacing)
        ])
        slidersStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slidersStackView.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: Constants.slidersStackViewTopSpacing),
            slidersStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.slidersStackViewSideSpacing),
            slidersStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.slidersStackViewSideSpacing)
        ])
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: slidersStackView.bottomAnchor, constant: Constants.saveButtonTopSpacing),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.saveButtonSideSpacing),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.saveButtonSideSpacing),
            saveButton.heightAnchor.constraint(equalToConstant: Constants.saveButtonHeightSpacing)
        ])
    }
}
