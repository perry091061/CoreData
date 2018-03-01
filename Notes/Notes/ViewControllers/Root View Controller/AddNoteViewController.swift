//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Perry Davies on 26/02/2018.
//  Copyright © 2018 Perry Davies. All rights reserved.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {

    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var contentTextView:UITextView!
    
    var managedObjectContext:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Note"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func save(sender: UIBarButtonItem) {
        guard let managedObjectContext = managedObjectContext else { return }
        
        guard let title = titleTextField.text, !title.isEmpty else {
            // Title field is manditory
               showAlert(with: "Title Missing!", and: "your note does not have a title?")
            return
        }
        
        // Create note
        let note = Note(context: managedObjectContext)
        // Configure note
        note.createdAt = Date()
        note.updatedAt = Date()
        note.title = titleTextField.text
        note.contents = contentTextView.text
        
        _ = navigationController?.popViewController(animated: true)
    }

     
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
