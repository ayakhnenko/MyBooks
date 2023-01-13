//
//  DataController.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 03.10.2022.
//

import Foundation
import CoreData
import SwiftUI

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "BookModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data save")
        } catch {
            print("We could not save the data")
        }
    }
    
    func addBook(name: String, image: UIImage, author: String, startDate: Date, comments: String, finishDate: Date, isFavourite: Bool, range: Int16, readingNow: Bool, context: NSManagedObjectContext) {
        let book = Book(context: context)
        book.id = UUID()
        book.name = name
        book.author = author
        book.startDate = startDate
        book.comments = comments
        book.finishDate = finishDate
        book.isFavourite = isFavourite
        book.range = Int16(range)
        book.image = image.pngData()
        book.readingNow = readingNow
        
        save(context: context)
    }
    
    func editBook(book: Book, name: String, image: UIImage, author: String, startDate: Date, comments: String, finishDate: Date, isFavourite: Bool, readingNow: Bool, range: Int, context: NSManagedObjectContext) {
        book.name = name
        book.author = author
        book.comments = comments
        book.startDate = startDate
        book.finishDate = finishDate
        book.isFavourite = isFavourite
        book.range = Int16(range)
        book.image = image.pngData()
        book.readingNow = readingNow
        
        save(context: context)
    }
    
    
}
