//
//  FavouriteBookListViewModel.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 13.02.2023.
//

import Foundation
import CoreData

class FavouriteBookListViewModel: ObservableObject {
    
    private (set) var context: NSManagedObjectContext
   
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    
    
   
    //    let request = API.fetchRequest()
    //    let sort = NSSortDescriptor(keyPath: \API.priority, ascending: true)
    //    request.sortDescriptors = [sort]
    //    do {
    //      if let apis = try container.viewContext.fetch(request) as? [API] {
    //        logger.debug("APIs fetched: \(apis.count)")
    //        self.apis = apis
    //      }
    //    } catch {
    //      logger.debug("Fetch failed 😭")
    //    }
}
