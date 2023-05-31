//
//  MainTableView.swift
//  MyFirstApp_20.02.
//
//  Created by Владислав on 27.02.2023.
//

import UIKit

protocol MainDeleteTableViewProtocol: AnyObject {
    func deleteWorkout(model: WorkoutModel, index: Int)
}

class MainTableView: UITableView {
    enum Constants {
        static let idTableViewCell = "idTableViewCell"
    }
    
    private var workoutArray = [WorkoutModel]()
    
    weak var mainDeleteDelegate: MainDeleteTableViewProtocol?

    //MARK: - Lifecycle
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configure()
        setsDelegets()
        register(WorkoutTableViewCell.self, forCellReuseIdentifier: Constants.idTableViewCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .none
        separatorStyle = .none
        bounces = false
        showsVerticalScrollIndicator = false
    }
    
    private func setsDelegets() {
        delegate = self
        dataSource = self
    }
    
    public func setWorkoutArray(array: [WorkoutModel]) {
        workoutArray = array
    }
    
}

//MARK: - UITableViewDataSource

extension MainTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workoutArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.idTableViewCell, for: indexPath) as? WorkoutTableViewCell else { return UITableViewCell() }
        let workoutModel = workoutArray[indexPath.row]
        cell.configure(model: workoutModel)
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate

extension MainTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "") { [weak self] _, _, _ in
            guard let self = self else { return }
            let deleteModel = self.workoutArray[indexPath.row]
            self.mainDeleteDelegate?.deleteWorkout(model: deleteModel, index: indexPath.row)
        }
        
        action.backgroundColor = .specialBackground
        action.image = UIImage(named: "delete")
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}
