//
//  AddToDoViewController.swift
//  ToDoApp
//
//  Created by Michael Stroh on 29.12.15.
//  Copyright © 2015 Michael Stroh. All rights reserved.
//

import UIKit
import CoreData

class AddToDoViewController: UIViewController, UITextFieldDelegate {
    
    //lazy var chosenDate: NSDate = NSDate()
    var chosenDateAsString = ""
    var toDoNameAsString = ""
    var toDoDescriptionAsString = ""
    var toDoEstimatedTimeAsString = ""
    
    @IBOutlet weak var toDoNameTextfieldOutlet: UITextField!
    @IBOutlet weak var toDoDescriptionTextfieldOutlet: UITextField!
    @IBOutlet weak var toDoEstimatedTimeTextfieldOutlet: UITextField!
    @IBOutlet weak var chosenDateOutlet: UILabel!
    
    // Funktion handelt die Interaktion mit dem Save-Button
    @IBAction func saveButtonClicked(sender: UIButton) {
        if toDoNameAsString == "" {
            //print("Error: Giving the ToDo a name is a must")
            let alert = UIAlertController(title: "Missing name", message: "Please add a name for the toDo.", preferredStyle: .Alert)
            /* Funktion um über die DialogBox einen Namen hinzufügen zu können
            let addNewAction = UIAlertAction(title: "Add", style: .Default){(_) in
                let nameTextField = alert.textFields![0]
            }*/
            let cancelAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
            
            //alert.addTextFieldWithConfigurationHandler(nil)
            
            //alert.addAction(addNewAction)
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            // Zugriff auf CoreData
            let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            // ManagedObjectContext verwaltet sämtliche Datenobjekte
            let context: NSManagedObjectContext = appDel.managedObjectContext
            
            // Ein neues ToDo anlegen für die Entity "ToDos" in CoreData
            let newToDo = NSEntityDescription.insertNewObjectForEntityForName("ToDos", inManagedObjectContext: context)
            newToDo.setValue(toDoNameAsString, forKey: "toDoName")
            newToDo.setValue(toDoDescriptionAsString, forKey: "toDoDesc")
            newToDo.setValue(toDoEstimatedTimeAsString, forKey: "toDoEstim")
            newToDo.setValue(chosenDateAsString, forKey: "toDoDate")
            
            // Das ToDo der Entity hinzufügen
            do {
                try context.save()
            } catch {
                print("Error while trying to save data in CoreData in function saveButtonClicked")
            }
            
            // Textfelder wieder zurücksetzen
            toDoNameTextfieldOutlet.text = ""
            toDoDescriptionTextfieldOutlet.text = ""
            toDoEstimatedTimeTextfieldOutlet.text = ""
            chosenDateOutlet.text = ""
            
            // Nach Klicken des Save Buttons wird ein Segue ausgeführt zurück zur TableView
            // Manuell angelegt
            performSegueWithIdentifier("SaveButton", sender: self)
            
        }
    }
    
    
    // Implementierte Funktion von UITextFieldDelegate
    // Reagiert auf gedrückten Return-Button innerhalb der beiden Textfelder
    // Wichtig: Outlets müssen vorher beim ViewController als OutletDelegate registriert werden!
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case toDoNameTextfieldOutlet:
            toDoNameAsString = toDoNameTextfieldOutlet.text!
            toDoDescriptionTextfieldOutlet.becomeFirstResponder()
        case toDoDescriptionTextfieldOutlet:
            toDoDescriptionAsString = toDoDescriptionTextfieldOutlet.text!
            toDoEstimatedTimeTextfieldOutlet.becomeFirstResponder()
        case toDoEstimatedTimeTextfieldOutlet:
            toDoEstimatedTimeAsString = toDoEstimatedTimeTextfieldOutlet.text!
            toDoEstimatedTimeTextfieldOutlet.resignFirstResponder()
        default:
            print("Wrong case in func textFieldShouldReturn AddToDoViewController")
        }

        return true
    }
    
    // Funktion handelt die Datenübertragung via Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ChooseDate" {
            let destinationController = segue.destinationViewController as! ChooseDateViewController
            destinationController.toDoName = toDoNameAsString
            destinationController.toDoDescription = toDoDescriptionAsString
            destinationController.toDoEstimatedTime = toDoEstimatedTimeAsString
        } else if segue.identifier == "SaveButton" {
            print("segue.identifier: \(segue.identifier)")
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        toDoNameTextfieldOutlet.text = toDoNameAsString
        toDoDescriptionTextfieldOutlet.text = toDoDescriptionAsString
        toDoEstimatedTimeTextfieldOutlet.text = toDoEstimatedTimeAsString
        chosenDateOutlet.text = chosenDateAsString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
