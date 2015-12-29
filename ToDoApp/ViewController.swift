//
//  ViewController.swift
//  ToDoApp
//
//  Created by Michael Stroh on 29.12.15.
//  Copyright © 2015 Michael Stroh. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var toDoArray = ["Pizza backen", "Vokabeln lernen", "Grammatik lernen"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCell") as UITableViewCell!
        cell.textLabel?.text = toDoArray[indexPath.row]
        
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

