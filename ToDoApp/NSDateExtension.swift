//
//  NSDateExtension.swift
//  ToDoApp
//
//  Created by Michael Stroh on 30.12.15.
//  Copyright © 2015 Michael Stroh. All rights reserved.
//

import Foundation

extension NSDate {
    
    func convertStringToNSDate(stringToConvert: String) -> NSDate {
        var convertedString: NSDate = NSDate.init()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
        
        if dateFormatter.dateFromString(stringToConvert) != nil {
            convertedString = dateFormatter.dateFromString(stringToConvert)!
        }
        
        return convertedString
    }
    
    func convertNSDateToString(nsDateToConvert: NSDate) -> String {
        var convertedNSDate: String = ""
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
        convertedNSDate = dateFormatter.stringFromDate(nsDateToConvert)
        
        return convertedNSDate
    }
    
    // Funktion prüft ob ein übergebenes Objekt vom Typ NSDate zeitlich nach dem eigenen liegt.
    func isAfterDate(dateToCompare: NSDate) -> Bool {
        var isAfter: Bool = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
        {
            isAfter = true
        }
        
        return isAfter
    }
    
    // Funktion prüft ob ein übergebenes Objekt vom Typ NSDate zeitlich vor dem eigenen liegt.
    func isBeforeDate(dateToCompare: NSDate) -> Bool {
        var isBefore: Bool = false
        
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
        {
            isBefore = true
        }
        
        return isBefore
    }
    
    func isToday(dateToCompare: NSDate) -> Bool {
        var isToday: Bool = false
        
        return isToday
    }
    
    func isInCurrentWeek(dateToCompare: NSDate) -> Bool {
        var isInCurrentWeek: Bool = false
        
        return isInCurrentWeek
    }
    
    func isNextWeek(dateToCompare: NSDate) -> Bool {
        var isNextWeek: Bool = false
        
    }
    
    func isFarFarAway(dateToCompare: NSDate) -> Bool {
        var isFarFarAway: Bool = false
        
        return isFarFarAway
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