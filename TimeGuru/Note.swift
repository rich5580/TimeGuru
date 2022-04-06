//
//  Note.swift
//  TimeGuru
//
//  Created by Harlan Rich on 2022-04-06.
//

import CoreData

@objc(Note)

class Note: NSManagedObject {
    
    @NSManaged var id: NSNumber!
    @NSManaged var title: String!
    @NSManaged var desc: String!
    @NSManaged var deletedDate: Date?
    
}
