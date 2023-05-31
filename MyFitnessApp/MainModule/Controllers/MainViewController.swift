//
//  ViewController.swift
//  MyFitnessApp
//
//  Created by Владислав on 20.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    enum Constants {
        static let userPhotoTopSpacing: CGFloat = 10.0
        static let userImageLeadingSpacing: CGFloat = 13.0
        static let userImageSize: CGFloat = 100.0
        static let calendarViewSideSpacing: CGFloat = 13.0
        static let calendarViewHeightSize: CGFloat = 70.0
        static let userNameTopSpacing: CGFloat = 7.0
        static let userNameLeadingSpacing: CGFloat = 6.0
        static let addButtonWorkoutTopSpacing: CGFloat = 6.0
        static let addButtonWorkoutLeadingSpacing: CGFloat = 13.0
        static let addButtonWorkoutSize: CGFloat = 80.0
        static let weatherViewTopSpacing: CGFloat = 6.0
        static let weatherViewLeadingSpacing: CGFloat = 10.0
        static let weatherViewTrailingSpacing: CGFloat = 12.0
        static let weatherViewSize: CGFloat = 80.0
        static let workoutTodayLabelTopSpacing: CGFloat = 14.0
        static let workoutTodayLabelLeadingSpacing: CGFloat = 13.0
        static let workoutTableViewTopSpacing: CGFloat = 5.0
        static let workoutTableViewSideSpacing: CGFloat = 0.0
        static let noWorkoutImageViewTopSpacing: CGFloat = 24.0
    }
    
    //MARK: - Create UI
    
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .specialLine
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .specialDarkGreen
        label.text = "Your Name"
        label.font = .robotoMedium24()
        return label
    }()
    
    private lazy var addWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tintColor = .specialDarkGreen
        button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 20,
                                              bottom: 15,
                                              right: 0)
        button.setTitle("Add workout", for: .normal)
        button.setTitleColor(.specialDarkGreen, for: .normal)
        button.titleLabel?.font = .robotoMedium12()
        button.titleEdgeInsets = UIEdgeInsets(top: 50,
                                              left: -40,
                                              bottom: 0,
                                              right: 0)
        button.addShadowOnView()
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var noWorkoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noWorkout")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let calendarView = CalendarView()
    private let weatherView = WeatherView()
    private let workoutTodayLabel = UILabel(text: "Workout today")
    private let workoutTableView = MainTableView()
    private var workoutArray = [WorkoutModel]()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectItem(date: Date())
    }
    
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(calendarView)
        calendarView.setDelegate(self)
        view.addSubview(userPhotoImageView)
        view.addSubview(userNameLabel)
        view.addSubview(addWorkoutButton)
        view.addSubview(weatherView)
        view.addSubview(workoutTodayLabel)
        view.addSubview(workoutTableView)
        workoutTableView.mainDeleteDelegate = self
        view.addSubview(noWorkoutImageView)
    }
    
    @objc
    private func addWorkoutButtonTapped() {
        let newWorkoutModuleViewController = NewWorkoutModuleViewController()
        newWorkoutModuleViewController.modalPresentationStyle = .fullScreen
        present(newWorkoutModuleViewController, animated: true)
    }
    
    private func getWorkouts(date: Date) {
        let weekday = date.getWeekdayNumber()
        let startDate = date.startEndDate().startDate
        let endDate = date.startEndDate().endDate
        
        let predicateRepeat = NSPredicate(format: "workoutNumberOfDay = \(weekday) AND workoutRepeat = true")
        let predicateUnrepeat = NSPredicate(format: "workoutRepeat = false AND workoutDate BETWEEN %@", [startDate, endDate])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
        
        let resultArray = RealmManager.shared.getResultWorkoutModel()
        let filtredArray = resultArray.filter(compound).sorted(byKeyPath: "workoutName")
        workoutArray = filtredArray.map({ $0 })
    }
    
    private func checkWorkoutToday() {
//        if workoutArray.count == 0 {
//            noWorkoutImageView.isHidden = false
//            workoutTableView.isHidden = true
//        } else {
//            noWorkoutImageView.isHidden = true
//            workoutTableView.isHidden = false
//        }
        noWorkoutImageView.isHidden = !workoutArray.isEmpty
        workoutTableView.isHidden = workoutArray.isEmpty
    }
}

//MARK: - CalendarViewProtocol

extension MainViewController: CalendarViewProtocol {
    func selectItem(date: Date) {
       getWorkouts(date: date)
        workoutTableView.setWorkoutArray(array: workoutArray)
        workoutTableView.reloadData()
        checkWorkoutToday()
    }
}

//MARK: - MainDeleteTableViewProtocol

extension MainViewController: MainDeleteTableViewProtocol {
    func deleteWorkout(model: WorkoutModel, index: Int) {
        RealmManager.shared.deleteWorkoutModel(model)
        workoutArray.remove(at: index)
        workoutTableView.setWorkoutArray(array: workoutArray)
        workoutTableView.reloadData()
    }
}

//MARK: - WorkoutCellProtocol

extension MainViewController: WorkoutCellProtocol {
    func startButtonTapped(model: WorkoutModel) {
        if model.workoutTimer == 0 {
            print("reps")
        } else {
            print("timer")
        }
    }
}

//MARK: - setConstraints()

extension MainViewController {
    private func setConstraints() {
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.userPhotoTopSpacing),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.userImageLeadingSpacing),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: Constants.userImageSize),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: Constants.userImageSize)
        ])
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: userPhotoImageView.topAnchor, constant: Constants.userImageSize / 2),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.calendarViewSideSpacing),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.calendarViewSideSpacing),
            calendarView.heightAnchor.constraint(equalToConstant: Constants.calendarViewHeightSize)
        ])
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -Constants.userNameTopSpacing),
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: Constants.userNameLeadingSpacing)
        ])
        addWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: Constants.addButtonWorkoutTopSpacing),
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.addButtonWorkoutLeadingSpacing),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: Constants.addButtonWorkoutSize),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: Constants.addButtonWorkoutSize)
        ])
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: Constants.weatherViewTopSpacing),
            weatherView.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: Constants.weatherViewLeadingSpacing),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.weatherViewTrailingSpacing),
            weatherView.heightAnchor.constraint(equalToConstant: Constants.weatherViewSize)
        ])
        workoutTodayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workoutTodayLabel.topAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor, constant: Constants.workoutTodayLabelTopSpacing),
            workoutTodayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.workoutTodayLabelLeadingSpacing),
            workoutTodayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.workoutTodayLabelLeadingSpacing)
        ])
        workoutTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            workoutTableView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: Constants.workoutTableViewTopSpacing),
            workoutTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.workoutTableViewSideSpacing),
            workoutTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.workoutTableViewSideSpacing),
            workoutTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.workoutTableViewSideSpacing)
        ])
        noWorkoutImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noWorkoutImageView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: Constants.noWorkoutImageViewTopSpacing),
            noWorkoutImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noWorkoutImageView.heightAnchor.constraint(equalTo: noWorkoutImageView.widthAnchor)
        ])
    }
}
