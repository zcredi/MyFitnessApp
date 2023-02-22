//
//  CalendarView.swift
//  MyFitnessApp
//
//  Created by Владислав on 20.02.2023.
//

import UIKit

class CalendarView: UIView {
    
    enum Constants {
        
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .calendarViewBackgroundColor
        layer.cornerRadius = 10
    }
 
}

extension CalendarView {
    private func setConstraints() {
        
    }
}
