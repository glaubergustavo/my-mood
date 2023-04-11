//
//  xAxisValueFormatter.swift
//  MyMood
//
//  Created by Glauber Gustavo on 10/04/23.
//

import Foundation
import Charts

class xAxisValueFormatter: AxisValueFormatter {
    
    var formattedDates: [String] = []
    var date: [Double] = []
    
    init(formattedDates: [String], date: [Double]) {
        self.formattedDates = formattedDates
        self.date = date
    }
    
    func findIndex( list: [Double],  value: Double) -> Int? {
        for (index, item) in list.enumerated() {
            if item == value {
                return index
            }
        }
        return nil
    }
    
    func stringForValue(_ value: Double, axis: Charts.AxisBase?) -> String {
        if date.contains(value) {
            return formattedDates[findIndex(list: date, value: value) ?? 0]
        }
        
        return Constants.Messages.Empty
    }
}
