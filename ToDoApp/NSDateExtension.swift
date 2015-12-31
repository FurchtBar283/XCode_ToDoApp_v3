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
    
    // isDateInToday benutzen?
    // isDateinTomorrow
    // Funktion prüft ob ein übergebenes Objekt vom Typ NSDate mit dem heutigen Tag übereinstimmt.
    func isToday(dateToCompare: NSDate) -> Bool {
        var isToday: Bool = false
        
        let cal = NSCalendar.currentCalendar()
        //let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var components = cal.components([.Era, .Year, .Month, .Day], fromDate: NSDate())
        let today = cal.dateFromComponents(components)!
        
        components = cal.components([.Era, .Year, .Month, .Day], fromDate: self)
        let otherDate = cal.dateFromComponents(components)!
        
        if(today.isEqualToDate(otherDate)) {
            isToday = true
        } else {
            isToday = false
        }
        
        return isToday
    }

    // Funktioniert leider nicht bei Woche im Jahresübergang
    // Funktion prüft ob ein übergebenes Objekt vom Typ NSDate in der aktuellen Woche liegt.
    func isInCurrentWeek(dateToCompare: NSDate) -> Bool {
        var isInCurrentWeek: Bool = false
        
        let cal = NSCalendar.currentCalendar()
        //let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let weekComparisonResult = cal.compareDate(dateToCompare, toDate: NSDate(), toUnitGranularity: NSCalendarUnit.WeekOfYear)
        
        switch weekComparisonResult {
        case NSComparisonResult.OrderedSame:
            isInCurrentWeek = true
            // Test-Ausgabe.
            //print("In func isInCurrentWeek in NSDateExtension NSComparisonResult.OrderedSame")
        case NSComparisonResult.OrderedAscending:
            isInCurrentWeek = false
            // Test-Ausgabe.
            //print("In func isInCurrentWeek in NSDateExtension NSComparisonResult.OrderedAscending")
        case NSComparisonResult.OrderedDescending:
            isInCurrentWeek = false
            // Test-Ausgabe.
            //print("In func isInCurrentWeek in NSDateExtension NSComparisonResult.OrderedDescending")
        }
        /*
        if isInCurrentWeek == true {
            let yearComparisonResult = cal.compareDate(dateToCompare, toDate: NSDate(), toUnitGranularity: NSCalendarUnit.Year)
            if yearComparisonResult == NSComparisonResult.OrderedSame {
                isInCurrentWeek = true
            } else {
                isInCurrentWeek = false
            }
        }
        */
        return isInCurrentWeek
    }
    
    // Funktion prüft ob ein übergebenes Objekt vom Typ NSDate in der nächsten Woche liegt.
    func isNextWeek(dateToCompare: NSDate) -> Bool {
        var isNextWeek: Bool = false
        let nextWeek: NSDate = NSDate.init().addWeeks(1)
        // Test-Ausgabe.
        //print(nextWeek)
        
        let cal = NSCalendar.currentCalendar()
        //let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let weekComparisonResult = cal.compareDate(dateToCompare, toDate: nextWeek, toUnitGranularity: NSCalendarUnit.WeekOfYear)
        
        switch weekComparisonResult {
        case NSComparisonResult.OrderedSame:
            isNextWeek = true
            // Test-Ausgabe.
            //print("In func isNextWeek in NSDateExtension NSComparisonResult.OrderedSame")
        case NSComparisonResult.OrderedAscending:
            isNextWeek = false
            // Test-Ausgabe.
            //print("In func isNextWeek in NSDateExtension NSComparisonResult.OrderedAscending")
        case NSComparisonResult.OrderedDescending:
            isNextWeek = false
            // Test-Ausgabe.
            //print("In func isNextWeek in NSDateExtension NSComparisonResult.OrderedDescending")
        }
        
        return isNextWeek
    }
    
    // Funktion prüft ob ein übergebenes Objekt vom Typ NSDate in einem Zeitraum größer als 7 Tage liegt.
    func isFarFarAway(dateToCompare: NSDate) -> Bool {
        var isFarFarAway: Bool = false
        let farFarAwayDate: NSDate = NSDate.init().addWeeks(2)
        // Test-Ausgabe.
        //print(farFarAwayDate)
        
        let cal = NSCalendar.currentCalendar()
        //let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let weekComparisonResult = cal.compareDate(dateToCompare, toDate: farFarAwayDate, toUnitGranularity: NSCalendarUnit.WeekOfYear)
        
        switch weekComparisonResult {
        case NSComparisonResult.OrderedSame:
            isFarFarAway = true
            // Test-Ausgabe.
            //print("In func isNextWeek in NSDateExtension NSComparisonResult.OrderedSame")
        case NSComparisonResult.OrderedAscending:
            isFarFarAway = false
            // Test-Ausgabe.
            //print("In func isNextWeek in NSDateExtension NSComparisonResult.OrderedAscending")
        case NSComparisonResult.OrderedDescending:
            isFarFarAway = true
            // Test-Ausgabe.
            //print("In func isNextWeek in NSDateExtension NSComparisonResult.OrderedDescending")
        }
        
        return isFarFarAway
    }
    
    // Funktion fügt einem Objekt vom Typ NSDate Stunden hinzu.
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: NSTimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.dateByAddingTimeInterval(secondsInHours)
        
        return dateWithHoursAdded
    }

    // Funktion fügt einem Objekt vom Typ NSDate Tage hinzu.
    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.dateByAddingTimeInterval(secondsInDays)
        
        return dateWithDaysAdded
    }
    
    // Funktion fügt einem Objekt vom Typ NSDate Wochen hinzu.
    func addWeeks(weeksToAdd: Int) -> NSDate {
        let secondsInWeeks: NSTimeInterval = Double(weeksToAdd) * 60 * 60 * 24 * 7
        let dateWithWeeksAdded: NSDate = self.dateByAddingTimeInterval(secondsInWeeks)
        
        return dateWithWeeksAdded
    }
}