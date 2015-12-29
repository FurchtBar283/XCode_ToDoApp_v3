//
//  AddToDoViewController.swift
//  ToDoApp
//
//  Created by Michael Stroh on 29.12.15.
//  Copyright © 2015 Michael Stroh. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController, UITextFieldDelegate {
    
    //lazy var chosenDate: NSDate = NSDate()
    var chosenDateAsString = ""
    var toDoName = ""
    var toDoDescription = ""
    var toDoEstimatedTime = ""
    
    @IBOutlet weak var toDoNameTextfieldOutlet: UITextField!
    @IBOutlet weak var toDoDescriptionTextfieldOutlet: UITextField!
    @IBOutlet weak var toDoEstimatedTimeTextfieldOutlet: UITextField!
    @IBOutlet weak var chosenDateOutlet: UILabel!
    
    // Implementierte Funktion von UITextFieldDelegate
    // Reagiert auf gedrückten Return-Button innerhalb der beiden Textfelder
    // Wichtig: Outlets müssen vorher beim ViewController als OutletDelegate registriert werden!
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case toDoNameTextfieldOutlet:
            toDoName = toDoNameTextfieldOutlet.text!
            toDoDescriptionTextfieldOutlet.becomeFirstResponder()
        case toDoDescriptionTextfieldOutlet:
            toDoDescription = toDoDescriptionTextfieldOutlet.text!
            toDoEstimatedTimeTextfieldOutlet.becomeFirstResponder()
        case toDoEstimatedTimeTextfieldOutlet:
            toDoEstimatedTime = toDoEstimatedTimeTextfieldOutlet.text!
            toDoEstimatedTimeTextfieldOutlet.resignFirstResponder()
        default:
            "Wrong case in func textFieldShouldReturn AddToDoViewController"
        }

        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ChooseDate" {
            let destinationController = segue.destinationViewController as! ChooseDateViewController
            destinationController.toDoName = toDoName
            destinationController.toDoDescription = toDoDescription
            destinationController.toDoEstimatedTime = toDoEstimatedTime
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        chosenDateOutlet.text = chosenDateAsString
        print(toDoName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
