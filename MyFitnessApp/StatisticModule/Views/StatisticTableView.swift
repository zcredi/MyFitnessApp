//
//  StatisticTableView.swift
//  MyFirstApp_20.02.
//
//  Created by Владислав on 28.02.2023.
//

import UIKit

class StatisticTableView: UITableView {
    enum Constants {
        static let idStatisticTableViewCell = "idStatisticTableViewCell"
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configure()
        setsDelegets()
        register(StatisticTableViewCell.self, forCellReuseIdentifier: Constants.idStatisticTableViewCell)
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

extension StatisticTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.idStatisticTableViewCell, for: indexPath) as? StatisticTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate

extension StatisticTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
}
