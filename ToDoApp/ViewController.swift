//
//  ViewController.swift
//  ToDoApp
//
//  Created by Michael Stroh on 29.12.15.
//  Copyright © 2015 Michael Stroh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var dataFromCoreData = [String: [String: String]]()
    // Konvertieren des Dictionaries(dataFromCoreData) in func tableView cellForRowAtIndexPath
    // in
    // mit indexPath.row als neuem Key
    var dataFromCoreDataWithIndexPathAsKey = [String: [String: String]]()
    // Wird in Segue zu ShowDetailsViewController als Key übergeben, um die entsprechenden
    // Dictionary-Einträge abzurufen
    var dictKeyIdentifier = Int.init()
    
    @IBOutlet var tableViewOutlet: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // DataRequest an CoreData
        fetchDatabase()
        // Aktualisieren der TableView
        tableViewOutlet.reloadData()
        
        // Ausgaben zu Testzwecken
        /*
        print(self.dataFromCoreData["Optional(Bierhoff )"])
        print("blabla")
        let person = dataFromCoreData["Optional(Bierhoff )"]!
        
        let text = person["toDoName"]
        let text2 = person["toDoDate"]
        print(text)
        print(text2)
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchDatabase() {
        // Zugriff auf CoreData
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // ManagedObjectContext verwaltet sämtliche Datenobjekte
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        // Daten aus CoreData abfragen
        do {
            // Request an die Entity "ToDos"
            let request = NSFetchRequest(entityName: "ToDos")
            // Rückgabewerte des Requests
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                for item in results as! [NSManagedObject] {
                    // ! behebt den Optional("...") Anzeigefehler
                    /* Zwischenschritt: Zwischenspeichern der einzelnen Werte in Variablen
                    let name = item.valueForKey("toDoName")!
                    let descr = item.valueForKey("toDoDesc")!
                    let estim = item.valueForKey("toDoEstim")!
                    let doDate = item.valueForKey("toDoDate")!
                    */
                    
                    // Zwischenspeicherung der CoreDataWerte im Dictionary dataFromCoreData
                    dataFromCoreData["\(item.valueForKey("toDoName")!)"] = ["toDoName": "\(item.valueForKey("toDoName")!)",
                        "toDoDesc": "\(item.valueForKey("toDoDesc")!)",
                        "toDoEstim": "\(item.valueForKey("toDoEstim")!)",
                        "toDoDate": "\(item.valueForKey("toDoDate")!)"]
                    
                    //print(dataFromCoreData["\(name)"])
                }
            }
            
        } catch {
            print("Error while trying to fetch data from CoreData in function fetchDatabase")
        }
    }
    
    // Skript-Version
    /*
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("ToDos", inManagedObjectContext: self.managedObjectContext)
        fetchRequest.entity = entity
        fetchRequest.fetchBatchSize = 20
        let sortDescriptor = NSSortDescriptor(key: "toDoName", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: "Master")
       // aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            abort()
        }
        
        return _fetchedResultsController!
    }
    
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    */
    
    
    // Diese Funktion setzt die Anzahl der Sections innerhalb der TableView
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Diese Funktion legt die Anzahl der Reihen/Cells pro Section fest
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Skript-Version
        /*
        let numberOfCells = self.fetchedResultsController.fetchedObjects?.count
        return numberOfCells!
        */
        return dataFromCoreData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCell") as UITableViewCell!
        
        // Dictionary-Werte aus CoreData umwandeln und zwischenspeichern
        // Den Key.. (hier: toDoName)
        let key   = Array(self.dataFromCoreData.keys)[indexPath.row]
        // ..und die dazugehörigen Werte (hier: toDoName, toDoDescr, toDoEstim, toDoDate)
        let value = Array(self.dataFromCoreData.values)[indexPath.row]
        
        // indexPath als neuen eindeutigen identifier bzw Key..
        // ..für den jeweiligen Eintrag im neuen Dictionary speichern
        let indexPathAsString = String(indexPath.row)
        // Dem neuen Dictionary(Mutable) mittels Key indexPathAsString die Werte zuweisen
        dataFromCoreDataWithIndexPathAsKey[indexPathAsString] = value
        
        // Der Cell den Key(toDoName) vom Dictionary(dataFromCoreData) als Text zuweisen
        cell.textLabel?.text = key
        
        return cell
    }
    
    // Reagiert wenn eine Zelle angewählt wurde
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected cell: \(indexPath.row)")
        
        // Idee: performSegueWithIdentifier (manueller Segue mit indexPath.row)
        dictKeyIdentifier = indexPath.row
        performSegueWithIdentifier("ShowDetails", sender: self)
    }
    
    // Diese Funktion setzt die entsprechende Zelle/Reihe auf editierbar
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Mit dieser Funktion kann man auf die Delete/Edit-Anweisungen reagieren
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print("Deleting cell: \(indexPath.row)")
            
            // Versuch Daten aus CoreData wieder zu löschen
            /* http://www.learncoredata.com/create-retrieve-update-delete-data-with-core-data/
            // 2
            let appDelegateOnDelete = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedObjContext = appDelegateOnDelete.managedObjectContext
            
            // 3
            managedObjContext.deleteObject(dataFromCoreData[indexPath.row])
            appDelegateOnDelete.saveContext()
            
            // 4
            dataFromCoreData.removeAtIndex(indexPath.row)
            tableView.reloadData()
            */
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetails" {
            let destinationControllerShowDetails = segue.destinationViewController as! ShowDetailsViewController
            destinationControllerShowDetails.indexPathHandedOver = dictKeyIdentifier
            destinationControllerShowDetails.dataFromCoreDataHandedOver = dataFromCoreDataWithIndexPathAsKey
        }
    }
}

