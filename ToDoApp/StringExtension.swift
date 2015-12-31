//
//  StringExtension.swift
//  ToDoApp
//
//  Created by Michael Stroh on 31.12.15.
//  Copyright © 2015 Michael Stroh. All rights reserved.
//

import Foundation

extension String {
 
    // Funktion konvertiert ein Objekt vom Typ NSDate in einen String des Formats "dd.MM.yyyy hh:mm"
    func convertStringToNSDate(stringToConvert: String) -> NSDate {
        var convertedString: NSDate = NSDate.init()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
        
        if dateFormatter.dateFromString(stringToConvert) != nil {
            convertedString = dateFormatter.dateFromString(stringToConvert)!
        }
        
        return convertedString
    }
    
    // Macht mehr Sinn in NSDateExtension -> moved
    /*
    func convertNSDateToString(nsDateToConvert: NSDate) -> String {
        var convertedNSDate: String = ""
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
        convertedNSDate = dateFormatter.stringFromDate(nsDateToConvert)
        
        return convertedNSDate
    }
    */
}