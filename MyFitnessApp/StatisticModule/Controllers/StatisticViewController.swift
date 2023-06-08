//
//  StatisticViewController.swift
//  MyFirstApp_20.02.
//
//  Created by Владислав on 28.02.2023.
//

import UIKit

class StatisticViewController: UIViewController {
    enum Constants {
        static let statisticLabelTopSpacing: CGFloat = 10.0
        static let segmentedControlTopSpacing: CGFloat = 30.0
        static let segmentedControlSideSpacing: CGFloat = 20.0
        static let exercisesLabelTopSpacing: CGFloat = 12.0
        static let exercisesLabelSideSpacing: CGFloat = 20.0
        static let statisticTableViewTopSpacing: CGFloat = 3.0
        static let statisticTableViewBottomSpacing: CGFloat = 3.0
        static let statisticTableViewSideSpacing: CGFloat = 0.0
    }
    
    //MARK: - Create UI
    
    private lazy var statisticLabel: UILabel = {
        let label = UILabel()
        label.textColor = .specialGray
        label.text = "STATISTICS"
        label.font = .robotoMedium24()
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Week", "Month"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .specialGreen
        segmentedControl.selectedSegmentTintColor = .specialDarkYellow
        let font = UIFont(name: "Roboto-Medium", size: 15)
        segmentedControl.setTitleTextAttributes([.font : font as Any, .foregroundColor : UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.font : font as Any, .foregroundColor : UIColor.specialGray], for: .selected)
        segmentedControl.addTarget(self, action: #selector(segmentedChange), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var exercisesLabel = UILabel(text: "Exercises")
    private lazy var statisticTableView = StatisticTableView()
    
    private var workoutArray = [WorkoutModel]()
    private var differenceArray = [DifferenceWorkout]()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setStartScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(statisticLabel)
        view.addSubview(segmentedControl)
        view.addSubview(exercisesLabel)
        view.addSubview(statisticTableView)
    }
    
    @objc
    private func segmentedChange() {
        let dateToday = Date()
        differenceArray = [DifferenceWorkout]()
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let dateStart = dateToday.offsetDay(day: 7)
            getDifferenceModel(dateStart: dateStart)
        } else {
            let dateStart = dateToday.offsetMonth(month: 1)
            getDifferenceModel(dateStart: dateStart)
        }
        statisticTableView.reloadData()
        
    }
    
    private func getWorkoutsName() -> [String] {
        var nameArray = [String]()
        
        let allWorkouts = RealmManager.shared.getResultWorkoutModel()
        
        for workoutModel in allWorkouts {
            if !nameArray.contains(workoutModel.workoutName) {
                nameArray.append(workoutModel.workoutName)
            }
        }
        
        return nameArray
    }
    
    private func getDifferenceModel(dateStart: Date) {
        let dateEnd = Date()
        let nameArray = getWorkoutsName()
        let allWorkouts = RealmManager.shared.getResultWorkoutModel()
        
        for name in nameArray {
            let predicateDifference = NSPredicate(format: "workoutName = '\(name)' AND workoutDate BETWEEN %@", [dateStart, dateEnd])
            let filtredArray = allWorkouts.filter(predicateDifference).sorted(byKeyPath: "workoutDate")
            workoutArray = filtredArray.map { $0 }
            
            guard let last = workoutArray.last?.workoutReps,
                  let first = workoutArray.first?.workoutReps else {
                return
            }
            
            let differenceWorkout = DifferenceWorkout(name: name, lastReps: last, firstReps: first)
            differenceArray.append(differenceWorkout)
        }
        statisticTableView.setDifferenceArray(array: differenceArray)
    }
    
    private func setStartScreen() {
        let dateToday = Date()
        differenceArray = [DifferenceWorkout]()
        getDifferenceModel(dateStart: dateToday.offsetDay(day: 7))
        statisticTableView.reloadData()
    }
}

//MARK: - setConstraints()

extension StatisticViewController {
    private func setConstraints() {
        statisticLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statisticLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.statisticLabelTopSpacing),
            statisticLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: statisticLabel.bottomAnchor, constant: Constants.segmentedControlTopSpacing),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.segmentedControlSideSpacing),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.segmentedControlSideSpacing)
        ])
        exercisesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exercisesLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: Constants.exercisesLabelTopSpacing),
            exercisesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.exercisesLabelSideSpacing),
            exercisesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.exercisesLabelSideSpacing)
        ])
        statisticTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statisticTableView.topAnchor.constraint(equalTo: exercisesLabel.bottomAnchor, constant: Constants.statisticTableViewTopSpacing),
            statisticTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.statisticTableViewSideSpacing),
            statisticTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.statisticTableViewSideSpacing),
            statisticTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.statisticTableViewBottomSpacing)
        ])
    }
}
