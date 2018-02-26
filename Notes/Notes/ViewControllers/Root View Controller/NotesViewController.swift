//
//  ViewController.swift
//  Notes
//
//  Created by Perry Davies on 29/01/2018.
//  Copyright © 2018 Perry Davies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let coreDataManager = CoreDataManager(modelName: "Notes")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
            case "AddNote":
            guard let destination = segue.destination as? AddNoteViewController else { return }
            
            destination.managedObjectContext = coreDataManager.managedObjectContext
        
           default: break
        }
            
        
    }

}

