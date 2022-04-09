//
//  EditEventViewController.swift
//  TimeGuru
//
//  Created by Harlan Rich on 2022-04-01.
//

import UIKit

class EditEventViewController: UIViewController {
    
    @IBOutlet weak var labelName: UITextField!
    @IBOutlet weak var eventPicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        eventPicker.date = selectedDate
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        if (labelName.text != "") {
            let newEvent = Event()
            newEvent.id = UUID().uuidString
            newEvent.name = labelName.text
            newEvent.date = eventPicker.date
            eventsList.append(newEvent)
            navigationController?.popViewController(animated: true)
        } else {
            alertPopUp(title: "Label is a Required Field")
        }
       
    }
    
    func alertPopUp (title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
        

