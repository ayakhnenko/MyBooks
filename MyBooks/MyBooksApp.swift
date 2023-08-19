//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 03.10.2022.
//

import SwiftUI

@main
struct MyBooksApp: App {
    
    let viewContext = DataController.shared.container.viewContext
    
    var body: some Scene {
        WindowGroup {
           ContentView()
                .environment(\.managedObjectContext, viewContext)
               
        }
    }
}
