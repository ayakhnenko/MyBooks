//
//  BookListViewModel.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 11.02.2023.
//

import Foundation
import CoreData
import UIKit


@MainActor
class BookListViewModel: NSObject, ObservableObject {
    
    
  @Published var books: [BookViewModel] = []
    private (set) var context: NSManagedObjectContext
    private var fetchResultsController: NSFetchedResultsController<Book>
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
       fetchResultsController = NSFetchedResultsController(fetchRequest: Book.all, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
            guard let books = fetchResultsController.fetchedObjects else {
                return
            }
            
            self.books = books.map(BookViewModel.init)
        } catch {
            print(error)
        }
    }
    
    func deleteBook(bookId: NSManagedObjectID) {
        do {
            guard let book = try context.existingObject(with: bookId) as? Book else {
                return
            }
            try book.delete()
        } catch {
            print(error)
        }
    }
}
    
extension BookListViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let books = controller.fetchedObjects as? [Book] else {
            return
            
        }
        self.books = books.map(BookViewModel.init)
    }
}
    
    
//    func fetchBooks() {
//        let request = NSFetchRequest<Book>(entityName: "Book")
//
//        do {
//            savedEntities = try dataController.container.viewContext.fetch(request)
//        } catch let error {
//            print("Error fetching. \(error)")
//        }
//    }
    
//    func deleteBook(indexSet: IndexSet) {
//        guard let index = indexSet.first else { return }
//        let entity = savedEntities[index]
//        dataController.container.viewContext.delete(entity)
//        dataController.save()
//    }
//}


struct BookViewModel: Identifiable {

    public var book: Book

    init(book: Book) {
        self.book = book
    }

    var id: NSManagedObjectID {
        book.objectID
    }

    var image: UIImage {
        UIImage(data: book.image!)!
        
    }
    var name: String {
        book.name ?? ""
    
    }
    var author: String {
        book.author ?? ""
        
    }
    var readingNow: Bool {
        book.readingNow
    }
    var isFavourite: Bool {
        book.isFavourite
        
    }
    var comments: String {
       book.comments ?? ""
   
    }
    var startDate: Date {
       book.startDate ?? Date()
    
    }
    var finishDate: Date {
        book.finishDate ?? Date()
        
    }
    var range: Int16 {
       book.range
        
    }
}
