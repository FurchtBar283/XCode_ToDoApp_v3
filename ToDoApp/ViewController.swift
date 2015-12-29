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
    
    //var toDoArray = ["Pizza backen", "Vokabeln lernen", "Grammatik lernen"]
    var dataFromCoreData = [String: [String : String]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchDatabase()
        /*
        print("--------")
        print("--------")
        print("Jetzt kommts")
        print(self.dataFromCoreData["Optional(Zimmer saugen )"])
        print(self.dataFromCoreData["Optional(Bierhoff )"])
        print("--------")
        print("--------")
        print(dataFromCoreData.values)
        
        let person = dataFromCoreData["Optional(Bierhoff )"]!
        
        let text = person["toDoName"]
        let text2 = person["toDoDate"]
        print("--------")
        print("--------")
        print(text)
        print(text2)
        */
        /*
        print("hihi")
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
                    let name = item.valueForKey("toDoName")
                    let descr = item.valueForKey("toDoDesc")
                    let estim = item.valueForKey("toDoEstim")
                    let doDate = item.valueForKey("toDoDate")
                    
                    /*
                    print(name)
                    print(descr)
                    print(estim)
                    print(doDate)
                    print("-----")
                    */
                    /*
                    dataFromCoreData.updateValue(["toDoName":"\(name)"], forKey: "\(name)")
                    dataFromCoreData.updateValue(["toDoDesc":"\(descr)"], forKey: "\(name)")
                    dataFromCoreData.updateValue(["toDoEstim":"\(estim)"], forKey: "\(name)")
                    dataFromCoreData.updateValue(["toDoDate":"\(doDate)"], forKey: "\(name)")
                    */
                    /*
                    dataFromCoreData = [
                        "\(name)": [
                            "toDoName": "\(name)",
                            "toDoDesc": "\(descr)",
                            "toDoEstim": "\(estim)",
                            "toDoDate": "\(doDate)"
                        ]
                    ]
                    */
                    dataFromCoreData["\(name)"] = ["toDoName": "\(name)",
                        "toDoDesc": "\(descr)",
                        "toDoEstim": "\(estim)",
                        "toDoDate": "\(doDate)"]
                    
                    print(dataFromCoreData["\(name)"])
                }
            }
            
            
        } catch {
            print("Error while trying to fetch data from CoreData in function saveButtonClicked")
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
    
    
    // Diese Funktion setzt die Anzahl an Sections innerhalb der TableView
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Diese Funktion legt die Anzahl an Reihen/Cells pro Section fest
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
        //cell.textLabel?.text = toDoArray[indexPath.row]
        let key   = Array(self.dataFromCoreData.keys)[indexPath.row]
        //var value = Array(self.dataFromCoreData.values)[indexPath.row]
        cell.textLabel?.text = key
        
        return cell
    }
    
    // Reagiert wenn eine Zelle angewählt wurde
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected cell: \(indexPath.row)")
        let thisCell = tableView.dequeueReusableCellWithIdentifier("ToDoCell") as UITableViewCell!
        print(thisCell.textLabel?.text)
    }
    
    // Diese Funktion setzt die entsprechende Zelle/Reihe auf editierbar
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Mit dieser Funktion kann man auf die Delete/Edit-Anweisungen reagieren
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print("Deleting cell: \(indexPath.row)")
        }
    }
}

