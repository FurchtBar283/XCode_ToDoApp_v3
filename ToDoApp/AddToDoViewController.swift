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
        
        // Daten aus CoreData abfragen
        do {
            // Request an die Entity "ToDos"
            let request = NSFetchRequest(entityName: "ToDos")
            // Rückgabewerte des Requests
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                for item in results as! [NSManagedObject] {
                    let name = item.valueForKey("toDoName")
                    let descr = item.valueForKey("toDoDesc")
                    let estim = item.valueForKey("toDoEstim")
                    let doDate = item.valueForKey("toDoDate")
                    
                    print(name)
                    print(descr)
                    print(estim)
                    print(doDate)
                    print("-----")
                }
            }
            
            
        } catch {
            print("Error while trying to fetch data from CoreData in function saveButtonClicked")
        }
        
        // Textfelder wieder zurücksetzen
        toDoNameTextfieldOutlet.text = ""
        toDoDescriptionTextfieldOutlet.text = ""
        toDoEstimatedTimeTextfieldOutlet.text = ""
        chosenDateOutlet.text = ""
        
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
            "Wrong case in func textFieldShouldReturn AddToDoViewController"
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
