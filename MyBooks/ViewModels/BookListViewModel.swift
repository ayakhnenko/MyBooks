//
//  BookListViewModel.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 11.02.2023.
//

//import Foundation
import CoreData
import SwiftUI



class BookListViewModel: NSObject, ObservableObject {
   
    private var storage = NavigationStorage.shared
    @Published var books: [BookModel] = []
    @Published var favBooks: [BookModel] = []
    private (set) var context: NSManagedObjectContext
    private var fetchResultsController: NSFetchedResultsController<Book>
    
    public var arrayYears: [String] {
         var years = [String]()
        for book in books {
            years.append(book.finishDate.dateYear())
            years = Array(Set(years))
            years.sort { $0 > $1 }
        }
        return years
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
    @Published var isNotFinish = false

    
    func bookCounter(year: String) -> Int {
        var count = 0
        for book in books {
            if book.finishDate.dateYear() == year && book.readingNow == false  && book.isNotFinish == false {
                count += 1
            }
        }
        return count
    }
    
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
            self.books = books.map(BookModel.init)
            
        } catch {
            print(error)
        }
        favBooks = books.filter({ $0.isFavourite })
        print("Book list vm init")
    }
    

   
    func selectModelIntent(book: BookModel) {
        storage.path.append(book)
       // detailBookViewModelSpawn(book: book)
    }
    
//    private (set) var detailBookViewModel: DetailBookViewModel?
//
//    func detailBookViewModelSpawn(book: BookViewModel) {
//        detailBookViewModel = DetailBookViewModel(context: context, parent: self, book: book)
//        storage.path.append(book)
//
//    }
//
//
//    func detailBookViewModelDispose() {
//        detailBookViewModel = nil
//    }
    
    func addBook(name: String, image: UIImage, author: String, startDate: Date, comments: String, finishDate: Date, isFavourite: Bool, range: Int16, readingNow: Bool, isNotFinish: Bool) {
        
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
            book.image = image.jpegData(compressionQuality: 0.5)
            book.readingNow = readingNow
            book.isNotFinish = isNotFinish
            
            try book.save()
        } catch {
            print(error)
        }
     }
    
    func editBook(book: Book, name: String, image: UIImage, author: String, startDate: Date, comments: String, finishDate: Date, isFavourite: Bool, readingNow: Bool, range: Int, isNotFinish: Bool) {
        
        do {
            book.name = name
            book.author = author
            book.comments = comments
            book.startDate = startDate
            book.finishDate = finishDate
            book.isFavourite = isFavourite
            book.range = Int16(range)
            book.image = image.jpegData(compressionQuality: 0.5)
            book.readingNow = readingNow
            book.isNotFinish = isNotFinish
            
            try book.save()
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
    
    
    
    deinit {
        print("BookListViewModel deinit")
    }
}
    
extension BookListViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let books = controller.fetchedObjects as? [Book] else {
            return
            
        }
        self.books = books.map(BookModel.init)
    }
}
  

struct BookModel: Identifiable, Hashable {

    public var book: Book

//    init(book: Book) {
//        self.book = book
//    }
//
    var id: NSManagedObjectID {
        book.objectID
    }

    var image: UIImage {
        UIImage(data: book.image!) ?? UIImage(imageLiteralResourceName: "boy")
        
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
    var isNotFinish: Bool {
        book.isNotFinish
    }
}
