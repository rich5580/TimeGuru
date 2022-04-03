//
//  CalendarDay.swift
//  TimeGuru
//
//  Created by Harlan Rich on 2022-04-01.
//

import Foundation

class CalendarDay
{
    var day: String!
    var month: Month!
    
    enum Month
    {
        case previous
        case current
        case next
    }
}
