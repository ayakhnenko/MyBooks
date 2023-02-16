//
//  DetailBookViewModel.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 11.02.2023.
//

import Foundation
import CoreData
import SwiftUI


class DetailBookViewModel: ObservableObject {
    
    private (set) var context: NSManagedObjectContext
    @Published var book: Book?
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    convenience init(context: NSManagedObjectContext, book: BookViewModel) {
        self.init(context: context)
        self.book = book.book
        
    }
    @Published var name = ""
    @Published var author = ""
    @Published var comments = ""
    @Published var startDate = Date()
    @Published var finishDate = Date()
    @Published var isFavourite = false
    @Published var range = 0
    @Published var image = UIImage(imageLiteralResourceName: "boy")
    @Published var readingNow = false

    
    func addBook(name: String, image: UIImage, author: String, startDate: Date, comments: String, finishDate: Date, isFavourite: Bool, range: Int16, readingNow: Bool) {
        
        do {
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
            
            try book.save()
        } catch {
            print(error)
        }
       
    
    }
    
    func editBook(book: Book, name: String, image: UIImage, author: String, startDate: Date, comments: String, finishDate: Date, isFavourite: Bool, readingNow: Bool, range: Int) {
        
        do {
            book.name = name
            book.author = author
            book.comments = comments
            book.startDate = startDate
            book.finishDate = finishDate
            book.isFavourite = isFavourite
            book.range = Int16(range)
            book.image = image.pngData()
            book.readingNow = readingNow
            
            try book.save()
        } catch {
            print(error)
        }
    }
}
