//
//  CalendarHelper.swift
//  TimeGuru
//
//  Created by Harlan Rich on 2022-03-31.
//

import Foundation
import UIKit

class CalendarHelper {
    let cal = Calendar.current
    
    func plusMonth(date: Date) -> Date {
        return cal.date(byAdding: .month, value: 1 ,to: date)!
    }
    
    func minusMonth(date: Date) -> Date {
        return cal.date(byAdding: .month, value: -1 ,to: date)!
    }
    
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func daysInMonth(date: Date) -> Int {
        let range = cal.range(of: .day, in: .month, for: date)!
        return range.count
    }
        
    func dayOfMonth(date: Date) -> Int {
        let components = cal.dateComponents([.day], from: date)
        return components.day!
    }
    
    func firstOfMonth(date: Date) -> Date {
        let components = cal.dateComponents([.year, .month], from: date)
        return cal.date(from: components)!
    }
    
    func weekDay(date: Date) -> Int {
        let components = cal.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    func addDays(date: Date, days: Int) -> Date {
        return cal.date(byAdding: .day, value: days, to: date)!
    }
    
    func sundayForDate(date: Date) -> Date {
        var current = date
        let oneWeekAgo = addDays(date: current, days: -7)
        
        while(current > oneWeekAgo)
        {
            let currentWeekDay = cal.dateComponents([.weekday], from: current).weekday
            if(currentWeekDay == 1)
            {
                return current
            }
            current = addDays(date: current, days: -1)
        }
        return current
    }
    
    func timeString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
