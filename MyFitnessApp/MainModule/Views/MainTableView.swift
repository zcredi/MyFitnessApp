//
//  MainTableView.swift
//  MyFirstApp_20.02.
//
//  Created by Владислав on 27.02.2023.
//

import UIKit

class MainTableView: UITableView {
    enum Constants {
        static let idTableViewCell = "idTableViewCell"
    }

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
    
}

//MARK: - UITableViewDataSource

extension MainTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.idTableViewCell, for: indexPath) as? WorkoutTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate

extension MainTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
