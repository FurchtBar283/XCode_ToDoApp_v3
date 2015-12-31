//
//  ChooseDateViewController.swift
//  ToDoApp
//
//  Created by Michael Stroh on 29.12.15.
//  Copyright © 2015 Michael Stroh. All rights reserved.
//

import UIKit

class ChooseDateViewController: UIViewController {
    
    var dateAsString = ""
    var toDoName = ""
    var toDoDescription = ""
    var toDoEstimatedTime = ""
    
    @IBAction func dateChosenAction(sender: UIDatePicker) {
        dateAsString = dateAsString.convertNSDateToString(sender.date)
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
            destinationController.toDoNameAsString = toDoName
            destinationController.toDoDescriptionAsString = toDoDescription
            destinationController.toDoEstimatedTimeAsString = toDoEstimatedTime
        }
    }
}
