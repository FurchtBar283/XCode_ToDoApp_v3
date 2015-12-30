//
//  NSDateExtension.swift
//  ToDoApp
//
//  Created by Michael Stroh on 30.12.15.
//  Copyright © 2015 Michael Stroh. All rights reserved.
//

import Foundation

extension NSDate {
    
    // Funktion prüft ob ein übergebenes Objekt vom Typ NSDate zeitlich nach dem eigenen liegt.
    func isAfterDate(dateToCompare: NSDate) -> Bool {
        var isAfter = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
        {
            isAfter = true
        }
        
        return isAfter
    }
    
    // Funktion prüft ob ein übergebenes Objekt vom Typ NSDate zeitlich vor dem eigenen liegt.
    func isBeforeDate(dateToCompare: NSDate) -> Bool {
        var isBefore = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
        {
            isBefore = true
        }
        
        return isBefore
    }

    // Derzeit nicht in Benutzung.
    /*
    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.dateByAddingTimeInterval(secondsInDays)
        
        return dateWithDaysAdded
    }
    
    
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: NSTimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.dateByAddingTimeInterval(secondsInHours)
        
        return dateWithHoursAdded
    }
    */
}