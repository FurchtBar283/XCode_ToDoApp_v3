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
    var sectionIdentifier = Int.init()
    var indexPathIdentifier = Int.init()
    
    var sectionHeaders = ["Today", "Tomorrow", "Current week", "Next week", "Far far away"]
    
    // Test.
    var dataFromCoreDataSectionToday = [String: [String: String]]()
    var dataFromCoreDataSectionTomorrow = [String: [String: String]]()
    var dataFromCoreDataSectionCurrentWeek = [String: [String: String]]()
    var dataFromCoreDataSectionNextWeek = [String: [String: String]]()
    var dataFromCoreDataSectionFarFarAway = [String: [String: String]]()
    var amountOfToDos: Int = 0
    var iterateToDos: Int = 0
    var dataFromCoreDataIterated = [String: [String: String]]()
    
    // Zählvariablen für die Anzahl an Einträgen pro Sektion
    var numberOfRowsInToday: Int = 0
    var numberOfRowsInTomorrow: Int = 0
    var numberOfRowsInCurrentWeek: Int = 0
    var numberOfRowsInNextWeek: Int = 0
    var numberOfRowsInFarFarAway: Int = 0
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
                    
                    countNumberOfRowsInSections()
                    
                    amountOfToDos++
                    
                    //print(dataFromCoreData["\(name)"])
                }
            }
            
        } catch {
            print("Error while trying to fetch data from CoreData in function fetchDatabase")
        }
    }
    
    func countNumberOfRowsInSections() {
        let givenDate = dateFromCoreDataAsNSDate
        
        // Test ob erkannt wird, falls ein Datum heute ist.
        // Funktioniert
        /*
        print(dateFromCoreDataAsString)
        print(dateFromCoreDataAsNSDate.isToday(dateFromCoreDataAsNSDate))
        print(dataFromCoreData["\(amountOfToDos)"])
        print("-----")
        */
        
        // Test ob erkannt wird, falls ein Datum in der aktuellen Woche liegt.
        // Funktioniert, außer bei Jahresübergangswoche
        /*
        print(dateFromCoreDataAsString)
        print(dateFromCoreDataAsNSDate.isInCurrentWeek(dateFromCoreDataAsNSDate))
        //print(dataFromCoreData["\(amountOfToDos)"])
        print("-----")
        */
        
        // Test ob erkannt wird, falls ein Datum in der nächsten Woche liegt.
        // Funktioniert
        /*
        print(dateFromCoreDataAsString)
        print(dateFromCoreDataAsNSDate.isNextWeek(dateFromCoreDataAsNSDate))
        //print(dataFromCoreData["\(amountOfToDos)"])
        print("-----")
        */
        
        // Test ob erkannt wird, falls ein Datum frühestens in der übernächsten Woche liegt.
        // Funktioniert
        /*
        print(dateFromCoreDataAsString)
        print(dateFromCoreDataAsNSDate.isFarFarAway(dateFromCoreDataAsNSDate))
        //print(dataFromCoreData["\(amountOfToDos)"])
        print("-----")
        */
        
        if givenDate.isBeforeDate(givenDate) {
                numberOfRowsInToday++
        } else if givenDate.isInCurrentWeek(givenDate) && !givenDate.isBeforeDate(givenDate) {
            if givenDate.isToday(givenDate) {
                numberOfRowsInToday++
            } else if givenDate.isTomorrow(givenDate) {
                numberOfRowsInTomorrow++
            } else {
                numberOfRowsInCurrentWeek++
            }
        } else if givenDate.isNextWeek(givenDate) {
            numberOfRowsInNextWeek++
        } else {
            numberOfRowsInFarFarAway++
        }
    }
    
    // Not in use
    /*
    func divideDataFromCoreDataInSections(coreDataDictionary: [String: String]) {
        //let givenDate = dateFromCoreDataAsNSDate

        
        // if date zugehörig zu section 0-4 -> Arbeiten in NSDateExtension
        // split in dicts
    }
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
    
    // Funktion prüft, ob eine Sektion leer ist.
    func checkForEmptySections(numberOfRowsInSection: Int) -> Bool {
        var sectionIsEmpty = false
        
        if numberOfRowsInSection == 0 {
            sectionIsEmpty = true
        }
        
        return sectionIsEmpty
    }
    
    // Funktion löscht leere Sektionen aus dem sectionHeader Array
    func hideEmptySections() {
        if checkForEmptySections(numberOfRowsInToday) {
            sectionHeaders = sectionHeaders.filter() { $0 != "Today" }
        }
        if checkForEmptySections(numberOfRowsInTomorrow) {
            sectionHeaders = sectionHeaders.filter() { $0 != "Tomorrow" }
        }
        if checkForEmptySections(numberOfRowsInCurrentWeek) {
            sectionHeaders = sectionHeaders.filter() { $0 != "Current week" }
        }
        if checkForEmptySections(numberOfRowsInNextWeek) {
            sectionHeaders = sectionHeaders.filter() { $0 != "Next week" }
        }
        if checkForEmptySections(numberOfRowsInFarFarAway) {
            sectionHeaders = sectionHeaders.filter() { $0 != "Far far away" }
        }
    }
    
    
    // Diese Funktion setzt die Anzahl der Sections innerhalb der TableView.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //hideEmptySections()
        
        return sectionHeaders.count
    }
    
    // Diese Funktion setzt die Titel der jeweiligen Sections.
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionHeader = ""
        
        switch section {
        case 0:
            sectionHeader = sectionHeaders[0]
        case 1:
            sectionHeader = sectionHeaders[1]
        case 2:
            sectionHeader = sectionHeaders[2]
        case 3:
            sectionHeader = sectionHeaders[3]
        case 4:
            sectionHeader = sectionHeaders[4]
        default:
            print("Error in tableView titleForHeaderInSection in ViewController")
        }
        
        return sectionHeader
    }
    
    // Diese Funktion legt die Anzahl der Reihen/Cells pro Section fest.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount: Int = 0
        
        switch section {
        case 0:
            rowCount = numberOfRowsInToday
        case 1:
            rowCount = numberOfRowsInTomorrow
        case 2:
            rowCount = numberOfRowsInCurrentWeek
        case 3:
            rowCount = numberOfRowsInNextWeek
        case 4:
            rowCount = numberOfRowsInFarFarAway
        default:
            print("Error in tableView numberOfRowsInSection in ViewController")
        }
        
        return rowCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //print(indexPath.section)
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCell") as UITableViewCell!
        // Test-Ausgaben.
        /*
        print("section : \(indexPath.section)")
        print("indexPath : \(indexPath.row)")
        */
        let dictValues = Array(self.dataFromCoreData.values)[iterateToDos++]
        sectionIdentifier = indexPath.section
        indexPathIdentifier = indexPath.row
        dataFromCoreDataIterated["\(sectionIdentifier).\(indexPathIdentifier)"] = dictValues
        let dateOfDictValuesAsString = dataFromCoreDataIterated["\(sectionIdentifier).\(indexPathIdentifier)"]!["toDoDate"]!
        let dateOfDictValuesAsNSDate = dateOfDictValuesAsString.convertStringToNSDate(dateOfDictValuesAsString)
        
        if dateOfDictValuesAsNSDate.isBeforeDate(dateOfDictValuesAsNSDate) {
            dataFromCoreDataSectionToday["\(sectionIdentifier).\(indexPathIdentifier)"] = dictValues
        } else if dateOfDictValuesAsNSDate.isInCurrentWeek(dateOfDictValuesAsNSDate) {
            if dateOfDictValuesAsNSDate.isToday(dateOfDictValuesAsNSDate) {
                dataFromCoreDataSectionToday["\(sectionIdentifier).\(indexPathIdentifier)"] = dictValues
            } else if dateOfDictValuesAsNSDate.isTomorrow(dateOfDictValuesAsNSDate) {
                dataFromCoreDataSectionTomorrow["\(sectionIdentifier).\(indexPathIdentifier)"] = dictValues
            } else {
                dataFromCoreDataSectionCurrentWeek["\(sectionIdentifier).\(indexPathIdentifier)"] = dictValues
            }
        } else if dateOfDictValuesAsNSDate.isNextWeek(dateOfDictValuesAsNSDate) {
            dataFromCoreDataSectionNextWeek["\(sectionIdentifier).\(indexPathIdentifier)"] = dictValues
        } else {
            dataFromCoreDataSectionFarFarAway["\(sectionIdentifier).\(indexPathIdentifier)"] = dictValues
        }
        
        let nameOfDictValues = dataFromCoreDataIterated["\(sectionIdentifier).\(indexPathIdentifier)"]!["toDoName"]!
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = nameOfDictValues
            // Speichern in neuem Dict
        case 1:
            cell.textLabel?.text = nameOfDictValues
        case 2:
            cell.textLabel?.text = nameOfDictValues
        case 3:
            cell.textLabel?.text = nameOfDictValues
        case 4:
            cell.textLabel?.text = nameOfDictValues
        default:
            print("Error in tableView cellForRowAtIndexPath in ViewController")
        }
        
        if checkIfToDoDateIsInPast(dateOfDictValuesAsString) {
            cell.textLabel?.text = nameOfDictValues + " (deprecated)"
            cell.textLabel?.textColor = UIColor.redColor()
        }
        
        return cell
    }
    
    // Reagiert wenn eine Zelle angewählt wurde.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected cell: \(indexPath.row)")
        
        // Idee: performSegueWithIdentifier (manueller Segue mit indexPath.row).
        sectionIdentifier = indexPath.section
        indexPathIdentifier = indexPath.row
        performSegueWithIdentifier("ShowDetails", sender: self)
    }
    
    // Diese Funktion setzt die entsprechende Zelle/Reihe auf editierbar.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Mit dieser Funktion kann man auf die Delete/Edit-Anweisungen reagieren.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print("Deleting cell:")
            print("in section: \(indexPath.section)")
            print("at indexPath: \(indexPath.row)")
            
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
            destinationControllerShowDetails.sectionHandedOver = sectionIdentifier
            destinationControllerShowDetails.indexPathHandedOver = indexPathIdentifier
            destinationControllerShowDetails.dataFromCoreDataHandedOver = dataFromCoreDataIterated
        }
    }
}

