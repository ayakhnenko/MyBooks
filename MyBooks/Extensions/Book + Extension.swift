//
//  Book + Extension.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 13.02.2023.
//

import Foundation
import CoreData


extension Book: BaseModel {
    
    static var all: NSFetchRequest<Book> {
        let request = Book.fetchRequest()
        request.sortDescriptors = []
        return request
    }
    
    static var favBooks: NSFetchRequest<Book> {
           let request = Book.fetchRequest()
           request.predicate = NSPredicate(format: "isFavourite == true")
           request.sortDescriptors = []
   
           return request
       }
}
