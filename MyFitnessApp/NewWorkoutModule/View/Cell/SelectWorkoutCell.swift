//
//  SelectWorkoutCell.swift
//  MyFitnessApp
//
//  Created by Владислав on 08.06.2023.
//

import UIKit

class SelectWorkoutCell: UICollectionViewCell {
    enum Constants {
        static let backViewSpacing: CGFloat = 5.0
        static let imageWorkoutSpacing: CGFloat = 5.0
    }
    
    static let idSelectWorkoutCell = "idSelectWorkoutCell"
    
    //MARK: - Create UI
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBackground
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var imageWorkout: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "testWorkout")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .specialDarkGreen
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layer.cornerRadius = 10
        addSubview(backView)
        backView.addSubview(imageWorkout)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelectWorkoutCell {
    func setConstraints() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.backViewSpacing),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.backViewSpacing),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.backViewSpacing),
        ])
        imageWorkout.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageWorkout.topAnchor.constraint(equalTo: backView.topAnchor, constant: Constants.imageWorkoutSpacing),
            imageWorkout.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: Constants.imageWorkoutSpacing),
            imageWorkout.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -Constants.imageWorkoutSpacing),
            imageWorkout.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -Constants.imageWorkoutSpacing)
        ])
    }
}
