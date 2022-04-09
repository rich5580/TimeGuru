import UIKit
import CoreData

class NoteDetailVC: UIViewController {
	@IBOutlet weak var titleText: UITextField!
	@IBOutlet weak var descText: UITextView!
	
	var selectedNote: Note? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if(selectedNote != nil) {
			titleText.text = selectedNote?.title
			descText.text = selectedNote?.desc
		}
	}


	@IBAction func saveAction(_ sender: Any) {
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        if (titleText.text != "") {
            if(selectedNote == nil) {
                let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
                let newNote = Note(entity: entity!, insertInto: context)
                newNote.id = noteList.count as NSNumber
                newNote.title = titleText.text
                newNote.desc = descText.text
                do {
                    try context.save()
                    noteList.append(newNote)
                    navigationController?.popViewController(animated: true)
                }catch {
                    print("context save error")
                }
            }else {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
                do {
                    let results:NSArray = try context.fetch(request) as NSArray
                    for result in results {
                        let note = result as! Note
                        if(note == selectedNote) {
                            note.title = titleText.text
                            note.desc = descText.text
                            try context.save()
                            navigationController?.popViewController(animated: true)
                        }
                    }
                }catch {
                    print("Fetch Failed")
                }
            }
        } else {
            alertPopUp(title: "Title is a Required Field")
        }
		
	}
    
    func alertPopUp (title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
	
	@IBAction func DeleteNote(_ sender: Any) {
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
		
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
		do {
			let results:NSArray = try context.fetch(request) as NSArray
			for result in results {
				let note = result as! Note
				if(note == selectedNote) {
					note.deletedDate = Date()
					try context.save()
					navigationController?.popViewController(animated: true)
				}
			}
		}catch {
			print("Fetch Failed")
		}
	}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
	
}

