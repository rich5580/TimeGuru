//
//  NoteViewController.swift
//  TimeGuru
//
//  Created by Harlan Rich on 2022-04-06.
//

import CoreData
import UIKit

class NoteViewController: UIViewController {
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    @IBAction func saveBtn(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        let newNote = Note(entity: entity!, insertInto: context)
        newNote.id = noteList.count as NSNumber
        newNote.title = titleText.text
        newNote.desc = descText.text
        
        do {
            try context.save()
            noteList.append(newNote)
            navigationController?.popViewController(animated: true)
        } catch {
            print("Context save error")
        }
        
    }
}
