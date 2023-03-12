//
//  Date + Extensions.swift
//  MyFitnessApp
//
//  Created by Владислав on 10.03.2023.
//

import Foundation

extension Date {
    func getWeekdayNumber() -> Int {
         let calendar = Calendar.current
         let weekday = calendar.component(.weekday, from: self)
        return weekday
    }
}
