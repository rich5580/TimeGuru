//
//  NoteDetailViewController.swift
//  TimeGuru
//
//  Created by Harlan Rich on 2022-04-06.
//

import CoreData
import UIKit

class NoteDetailViewController: UIViewController {
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descText: UITextView!
    
    var selectedNote: Note? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (selectedNote != nil) {
            titleText.text = selectedNote?.title
            descText.text = selectedNote?.desc
        }
        
        
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        if (titleText.text == "") {
            print("Nothing to add")
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            
            if (selectedNote == nil) {
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
            } else {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
                do {
                    let results:NSArray = try context.fetch(request) as NSArray
                    for result in results {
                        let note = result as! Note
                        if (note == selectedNote) {
                            note.title = titleText.text
                            note.desc = descText.text
                            
                            try context.save()
                            navigationController?.popViewController(animated: true)
                        }
                    }
                } catch {
                    print("Fetch Failed")
                }
            }
            
            
        }
        
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results {
                let note = result as! Note
                if (note == selectedNote) {
                    note.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        } catch {
            print("Fetch Failed")
        }
    }
    
}
