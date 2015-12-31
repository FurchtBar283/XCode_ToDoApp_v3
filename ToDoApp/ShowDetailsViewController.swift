//
//  ShowDetailsViewController.swift
//  ToDoApp
//
//  Created by Michael Stroh on 30.12.15.
//  Copyright © 2015 Michael Stroh. All rights reserved.
//

import UIKit

class ShowDetailsViewController: UIViewController {
    
    var sectionHandedOver = Int.init()
    var indexPathHandedOver = Int.init()
    var dataFromCoreDataHandedOver = [String:[String:String]]()
    
    @IBOutlet weak var nameLabelOutlet: UILabel!
    @IBOutlet weak var descriptionLabelOutlet: UILabel!
    @IBOutlet weak var estimatedTimeLabelOutlet: UILabel!
    @IBOutlet weak var dateLabelOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ///////////////
        // ÜBERARBEITEN
        ///////////////
        
        let givenToDo = dataFromCoreDataHandedOver["\(sectionHandedOver).\(indexPathHandedOver)"]!
        nameLabelOutlet.text = givenToDo["toDoName"]
        descriptionLabelOutlet.text = givenToDo["toDoDesc"]
        estimatedTimeLabelOutlet.text = givenToDo["toDoEstim"]! + " Minuten"
        dateLabelOutlet.text = givenToDo["toDoDate"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
