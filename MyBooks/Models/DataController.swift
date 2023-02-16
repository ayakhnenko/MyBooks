//
//  DataController.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 03.10.2022.
//

import Foundation
import CoreData


class DataController: ObservableObject {
    
   
    
   static let shared = DataController()
    let container: NSPersistentContainer
    
    
    init() {
        container = NSPersistentContainer(name: "BookModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
        //bookListViewModel.fetchBooks()
    }
  //  let bookListViewModel = BookListViewModel(context: DataController.shared.container.viewContext)
    
    
   
    
   
   
    
   
    
    
}
