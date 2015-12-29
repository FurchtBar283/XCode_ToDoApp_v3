//
//  ChooseDateViewController.swift
//  ToDoApp
//
//  Created by Michael Stroh on 29.12.15.
//  Copyright © 2015 Michael Stroh. All rights reserved.
//

import UIKit

class ChooseDateViewController: UIViewController {
    //var date:NSDate = NSDate()
    var dateAsString = ""
    var toDoName = ""
    var toDoDescription = ""
    var toDoEstimatedTime = ""
    
    @IBAction func dateChosenAction(sender: UIDatePicker) {
        //date = sender.date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
        let dateString = dateFormatter.stringFromDate(sender.date)
        //print(dateString)
        dateAsString = dateString
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ThatsIt" {
            let destinationController = segue.destinationViewController as! AddToDoViewController
            destinationController.chosenDateAsString = dateAsString
            destinationController.toDoName = toDoName
            destinationController.toDoDescription = toDoDescription
            destinationController.toDoEstimatedTime = toDoEstimatedTime
        }
    }
}
