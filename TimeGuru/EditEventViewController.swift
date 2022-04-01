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
        let newEvent = Event()
        newEvent.id = eventsList.count
        newEvent.name = labelName.text
        newEvent.date = eventPicker.date
        eventsList.append(newEvent)
        navigationController?.popViewController(animated: true)
    }
    
    
}
        

