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
    
    private let calendarView = CalendarView()
    private let weatherView = WeatherView()
    private let workoutTodayLabel = UILabel(text: "Workout today")
    private let workoutTableView = MainTableView()
    
    //MARK: - Lifecycle
    
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
    }
    
    @objc
    private func addWorkoutButtonTapped() {
        let newWorkoutModuleViewController = NewWorkoutModuleViewController()
        newWorkoutModuleViewController.modalPresentationStyle = .fullScreen
        present(newWorkoutModuleViewController, animated: true)
    }
}

//MARK: - CalendarViewProtocol

extension MainViewController: CalendarViewProtocol {
    func selectItem(date: Date) {
        print(date)
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
    }
}
