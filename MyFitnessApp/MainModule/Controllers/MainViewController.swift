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
    }
    
    //MARK: - Create UI
    
    private lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .userPhotoBackgroundColor
        imageView.layer.borderColor = UIColor.userPhotoBorderColor.cgColor
        imageView.layer.borderWidth = 5
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .userNameTextColor
        label.text = "Your Name"
        label.font = UIFont(name: UIFont.robotoMedium, size: 24)
        return label
    }()
    
    private lazy var addWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellowColor
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tintColor = .specialDarkGreenColor
        button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 20,
                                              bottom: 15,
                                              right: 0)
        button.setTitle("Add workout", for: .normal)
        button.setTitleColor(.specialDarkGreenColor, for: .normal)
        button.titleLabel?.font = UIFont(name: UIFont.robotoMedium, size: 12)
        button.titleEdgeInsets = UIEdgeInsets(top: 50,
                                              left: -40,
                                              bottom: 0,
                                              right: 0)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let calendarView = CalendarView()
    
    //MARK: - Lifecycle
    
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
   private func setupViews(){
       view.backgroundColor = .backgroundColor
       view.addSubview(calendarView)
       view.addSubview(userPhotoImageView)
       view.addSubview(userNameLabel)
       view.addSubview(addWorkoutButton)
    }
    
    @objc
    private func addWorkoutButtonTapped() {
        print("Tap tap")
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
    }
}
