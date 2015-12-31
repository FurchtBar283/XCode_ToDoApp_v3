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
    // Konvertieren des Dictionaries(dataFromCoreData) in func tableView cellForRowAtIndexPath..
    // .. in dataFromCoreDataWithIndexPathAsKey..
    // .. mit indexPath.row als neuem Key.
    var dataFromCoreDataWithIndexPathAsKey = [String: [String: String]]()
    // Wird in Segue zu ShowDetailsViewController als Key übergeben, um die entsprechenden..
    // .. Dictionary-Einträge abzurufen.
    var dictKeyIdentifier = Int.init()
    
    // Test.
    var dataFromCoreDataSectionToday = [String: [String: String]]()
    var dataFromCoreDataSectionTomorrow = [String: [String: String]]()
    var dataFromCoreDataSectionCurrentWeek = [String: [String: String]]()
    var dataFromCoreDataSectionNextWeek = [String: [String: String]]()
    var dataFromCoreDataSectionFarFarAway = [String: [String: String]]()
    var amountOfToDos: Int = 0
    
    // Zählvariablen für die Anzahl an Einträgen pro Sektion
    var numberOfRowsInToday: Int = 4
    var numberOfRowsInTomorrow: Int = 4
    var numberOfRowsInCurrentWeek: Int = 4
    var numberOfRowsInNextWeek: Int = 4
    var numberOfRowsInFarFarAway: Int = 4
    var dateFromCoreDataAsString: String = ""
    var dateFromCoreDataAsNSDate: NSDate = NSDate.init()
    
    @IBOutlet var tableViewOutlet: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // DataRequest an CoreData.
        fetchDatabase()
        // Aktualisieren der TableView.
        tableViewOutlet.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchDatabase() {
        // Zugriff auf CoreData.
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // ManagedObjectContext verwaltet sämtliche Datenobjekte.
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        // Daten aus CoreData abfragen.
        do {
            // Request an die Entity "ToDos".
            let request = NSFetchRequest(entityName: "ToDos")
            // Rückgabewerte des Requests.
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                for item in results as! [NSManagedObject] {
                    // ! behebt den Optional("...") Anzeigefehler.
                    /* Zwischenschritt: Zwischenspeichern der einzelnen Werte in Variablen.
                    let name = item.valueForKey("toDoName")!
                    let descr = item.valueForKey("toDoDesc")!
                    let estim = item.valueForKey("toDoEstim")!
                    let doDate = item.valueForKey("toDoDate")!
                    */
                    
                    // Zwischenspeicherung der CoreDataWerte im Dictionary dataFromCoreData.
                    dataFromCoreData["\(amountOfToDos)"] = ["toDoName": "\(item.valueForKey("toDoName")!)",
                        "toDoDesc": "\(item.valueForKey("toDoDesc")!)",
                        "toDoEstim": "\(item.valueForKey("toDoEstim")!)",
                        "toDoDate": "\(item.valueForKey("toDoDate")!)"]
                    
                    dateFromCoreDataAsString = dataFromCoreData["\(amountOfToDos)"]!["toDoDate"]!
                    dateFromCoreDataAsNSDate = dateFromCoreDataAsString.convertStringToNSDate(dateFromCoreDataAsString)
                    
                    // Test ob erkannt wird, falls ein Datum heute ist.
                    // Funktioniert
                    /*
                    print(dateFromCoreDataAsString)
                    print(dateFromCoreDataAsNSDate.isToday(dateFromCoreDataAsNSDate))
                    print(dataFromCoreData["\(amountOfToDos)"])
                    */
                    
                    // Test ob erkannt wird, falls ein Datum in der aktuellen Woche liegt.
                    // Funktioniert, außer bei Jahresübergangswoche
                    /*
                    print(dateFromCoreDataAsString)
                    print(dateFromCoreDataAsNSDate.isInCurrentWeek(dateFromCoreDataAsNSDate))
                    //print(dataFromCoreData["\(amountOfToDos)"])
                    */
                    
                    // Test ob erkannt wird, falls ein Datum in der nächsten Woche liegt.
                    // Funktioniert
                    /*
                    print(dateFromCoreDataAsString)
                    print(dateFromCoreDataAsNSDate.isNextWeek(dateFromCoreDataAsNSDate))
                    //print(dataFromCoreData["\(amountOfToDos)"])
                    */
                    
                    // Test ob erkannt wird, falls ein Datum frühestens in der übernächsten Woche liegt.
                    print(dateFromCoreDataAsString)
                    print(dateFromCoreDataAsNSDate.isFarFarAway(dateFromCoreDataAsNSDate))
                    //print(dataFromCoreData["\(amountOfToDos)"])
                    print("-----")
                    
                    
                    // Something like
                    /* How to identify each entry?
                    if givenDate.isBeforeDate(givenDate) {
                        dataFromCoreDataSectionToday
                        numberOfRowsInToday++
                    } else if givenDate.isInCurrentWeek(givenDate) {
                        // if givenDate.isDateInToday(givenDate) {
                        if givenDate.isToday(givenDate) {
                            dataFromCoreDataSectionToday
                            numberOfRowsInToday++
                        } else if givenDate.isDateInTomorrow(givenDate) {
                            dataFromCoreDataSectionTomorrow
                            numberOfRowsInTomorrow++
                        } else {
                            dataFromCoreDataSectionCurrentWeek
                            numberOfRowsInCurrentWeek++
                        }
                    } else if givenDate.isNextWeek(givenDate) {
                        dataFromCoreDataSectionNextWeek
                        numberOfRowsInNextWeek++
                    } else {
                        dataFromCoreDataSectionFarFarAway
                        numberOfRowsInFarFarAway++
                    }
                    */
                    
                    // if date zugehörig zu section 0-4 -> Arbeiten in NSDateExtension
                    // split in dicts
                    
                    amountOfToDos++
                    
                    //print(dataFromCoreData["\(name)"])
                }
            }
            
        } catch {
            print("Error while trying to fetch data from CoreData in function fetchDatabase")
        }
        divideDataFromCoreDataInSections(dataFromCoreData)
    }
    
    func divideDataFromCoreDataInSections(coreDataDictionary: [String: [String: String]]) {
        let countEntries = coreDataDictionary.count
        if countEntries == amountOfToDos {
            print("Gleich viele")
        }
        
  
        for item in 0..<amountOfToDos {
            print(item)
            let value = Array(coreDataDictionary.values)[item]
            if checkIfToDoDateIsInPast(value["toDoDate"]!) {
                //countForSectionDeprecated++
            } else {
                //countForSectionActive++
            }
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
    
    
    // Funktion prüft, ob das Datum einer ToDo in der Vergangenheit liegt.
    func checkIfToDoDateIsInPast(toDoDate: String) -> Bool {
        var isInPast: Bool = false
        var toDoDateAsNSDate = NSDate.init()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
        
        if dateFormatter.dateFromString(toDoDate) != nil {
            toDoDateAsNSDate = dateFormatter.dateFromString(toDoDate)!
            
            // Liegt das übergebene Datum in der Vergangenheit -> true.
            // NSDate() erzeugt zur Laufzeit den aktuellen Zeitstempel.
            // Zum Vergleich wird also der aktuelle Zeitstempel übergeben.
            if toDoDateAsNSDate.isBeforeDate(NSDate()) {
                isInPast = true
            }
        }
        
        return isInPast
    }
    
    
    // Diese Funktion setzt die Anzahl der Sections innerhalb der TableView.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    // Teil des neuen Tests.
    // Anfang..
    // Diese Funktion setzt die Titel der jeweiligen Sections.
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionHeader = ""
        
        switch section {
        case 0:
            sectionHeader = "Today"
        case 1:
            sectionHeader = "Current week"
        case 2:
            sectionHeader = "Next week"
        case 3:
            sectionHeader = "Far far away"
        default:
            "Error in tableView titleForHeaderInSection in ViewController"
        }
        
        return sectionHeader
    }
    // ..Ende!
    
    // Diese Funktion legt die Anzahl der Reihen/Cells pro Section fest.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Skript-Version.
        /*
        let numberOfCells = self.fetchedResultsController.fetchedObjects?.count
        return numberOfCells!
        */
        
        // Teil des neuen Tests.
        var rowCount: Int = 0
        switch section {
        case 0:
            rowCount = numberOfRowsInToday
        case 1:
            rowCount = numberOfRowsInCurrentWeek
        case 2:
            rowCount = numberOfRowsInNextWeek
        case 3:
            rowCount = numberOfRowsInFarFarAway
        default:
            "Error in tableView numberOfRowsInSection in ViewController"
        }
        
        return rowCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //print(indexPath.section)
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCell") as UITableViewCell!
        
        // Dictionary-Werte aus CoreData umwandeln und zwischenspeichern.
        // Den Key.. (hier: toDoName)
        //let key   = Array(self.dataFromCoreData.keys)[indexPath.row]
        // ..und die dazugehörigen Werte (hier: toDoName, toDoDescr, toDoEstim, toDoDate).
        //let value = Array(self.dataFromCoreData.values)[indexPath.row]
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "Active"
        } else {
            cell.textLabel?.text = "Deprecated"
        }
        /*
        
        // indexPath als neuen eindeutigen identifier bzw Key..
        // ..für den jeweiligen Eintrag im neuen Dictionary speichern.
        let indexPathAsString = String(indexPath.row)
        // Dem neuen Dictionary(Mutable) mittels Key(indexPathAsString) die Werte zuweisen.
        dataFromCoreDataWithIndexPathAsKey[indexPathAsString] = value
        
        // Datum der übergebenen ToDo zwischenspeichern..
        let toDoDate = dataFromCoreDataWithIndexPathAsKey[indexPathAsString]!["toDoDate"]!
        let toDoName = dataFromCoreDataWithIndexPathAsKey[indexPathAsString]!["toDoName"]!
        // .. und prüfen, ob es in der Vergangenheit liegt..
        if indexPath.section == 0 {
            if checkIfToDoDateIsInPast(toDoDate) {
                // .. falls ja, " (deprecated)" anhängen..
                cell.textLabel?.text = toDoName + " (deprecated)"
                // .. und den Text rot einfärben.
                cell.textLabel?.textColor = UIColor.redColor()
            } else {
                // Der Cell den Key(toDoName) vom Dictionary(dataFromCoreData) als Text zuweisen.
                cell.textLabel?.text = toDoName
            }
            
        } else if indexPath.section == 1 {
            if checkIfToDoDateIsInPast(toDoDate) {
                // .. falls ja, " (deprecated)" anhängen..
                cell.textLabel?.text = toDoName + " (deprecated)"
                // .. und den Text rot einfärben.
                cell.textLabel?.textColor = UIColor.redColor()
            } else {
                // Der Cell den Key(toDoName) vom Dictionary(dataFromCoreData) als Text zuweisen.
                cell.textLabel?.text = toDoName
            }
        }
        
        // Alte Umsetzung der Idee.
        /*
        // Idee: Wenn Datum in der Vergangenheit cell.textLabel?.text zusätzlich " (veraltet)" hinzufügen.
        // Anfang Idee //
        /////////////////
        let toDoDate = dataFromCoreDataWithIndexPathAsKey[indexPathAsString]!["toDoDate"]!
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
        let toDoDateAsNSDate = dateFormatter.dateFromString(toDoDate)
        //print(testDateAsNSDate)
        
        if toDoDateAsNSDate != nil {
            print(toDoDateAsNSDate)
            let datNSDate: NSDate = toDoDateAsNSDate!
            print(datNSDate)
            
            if datNSDate.isBeforeDate(NSDate()) {
                cell.textLabel?.text = key + " (deprecated)"
                cell.textLabel?.textColor = UIColor.redColor()
            }
        }
        ///////////////
        // Ende Idee //
        */
        */
        return cell
    }
    
    // Reagiert wenn eine Zelle angewählt wurde.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected cell: \(indexPath.row)")
        
        // Idee: performSegueWithIdentifier (manueller Segue mit indexPath.row).
        dictKeyIdentifier = indexPath.row
        performSegueWithIdentifier("ShowDetails", sender: self)
    }
    
    // Diese Funktion setzt die entsprechende Zelle/Reihe auf editierbar.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Mit dieser Funktion kann man auf die Delete/Edit-Anweisungen reagieren.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print("Deleting cell: \(indexPath.row)")
            
            // Versuch Daten aus CoreData wieder zu löschen.
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

