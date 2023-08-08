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
        static let nameViewHeightSpacing: CGFloat = 58.0
        static let selectWorkoutCollectionViewHeightSpacing: CGFloat = 85.0
        static let dateAndRepeatViewHeightSpacing: CGFloat = 115.0
        static let repsOrTimerViewHeightSpacing: CGFloat = 290.0
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
    private lazy var selectWorkoutCollectionView = SelectWorkoutCollectionView()
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
        addGesture()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(newWorkoutLabel)
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    
        slidersStackView = UIStackView(arrangedSubviews: [nameView,
                                                          selectWorkoutCollectionView,
                                                          dateAndRepeatView,
                                                          repsOrTimerView], axis: .vertical, spacing: 20)
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
        setModel()
        saveModel()
    }
    
    //MARK: - setModel()
    
    private func setModel() {
        let getDateAndRepeat = dateAndRepeatView.getDateAndRepeat()
        
        workoutModel.workoutName = nameView.getNameTextFieldText()
        workoutModel.workoutDate = getDateAndRepeat.date
        workoutModel.workoutRepeat = getDateAndRepeat.isRepeat
        workoutModel.workoutNumberOfDay = getDateAndRepeat.date.getWeekdayNumber()
        workoutModel.workoutSets = repsOrTimerView.sets
        workoutModel.workoutReps = repsOrTimerView.reps
        workoutModel.workoutTimer = repsOrTimerView.timer
        
        guard let imageData = workoutImage?.pngData() else { return }
        workoutModel.workoutImage = imageData
    }
    
    private func saveModel() {
        let text = nameView.getNameTextFieldText()
        let count = text.filter { $0.isNumber || $0.isLetter}.count
        
        if count != 0 &&
            workoutModel.workoutSets != 0 &&
            (workoutModel.workoutReps != 0 || workoutModel.workoutTimer != 0) {
            RealmManager.shared.saveWorkoutModel(workoutModel)
            
            presentSimpleAlert(title: "Success", message: nil)
            workoutModel = WorkoutModel()
            resetValues()
        } else {
            presentSimpleAlert(title: "Error", message: "Enter all parameters")
        }
    }
    
    private func resetValues() {
        nameView.deleteTextFieldText()
        dateAndRepeatView.resetDateAndRepeat()
        repsOrTimerView.resetRepsOrTimerParameters()
    }
    
    private func addGesture() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapScreen)
        
        let swipeScreen = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboard))
        swipeScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(swipeScreen)
    }
    
    @objc
    private func hideKeyboard() {
        view.endEditing(true)
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
        selectWorkoutCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameView.heightAnchor.constraint(equalToConstant: Constants.nameViewHeightSpacing),
            selectWorkoutCollectionView.heightAnchor.constraint(equalToConstant: Constants.selectWorkoutCollectionViewHeightSpacing),
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
