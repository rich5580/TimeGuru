//
//  NoteTableView.swift
//  TimeGuru
//
//  Created by Harlan Rich on 2022-04-06.
//

import UIKit

var noteList = [Note]()

class NoteTableView: UITableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCellID ", for: indexPath) as! NoteCell
        
        let thisNote: Note!
        thisNote = noteList[indexPath.row]
        noteCell.cellTitle.text = thisNote.title
        noteCell.cellDesc.text = thisNote.desc
        
        return noteCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
}
