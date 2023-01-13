//
//  ContentView.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 03.10.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.finishDate, order: .reverse)]) var book: FetchedResults<Book>
    
    
    @State private var selectedView = 1
    
    var body: some View {
        TabView(selection: $selectedView) {
            BookList()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Книжки")
                }.tag(1)
            
            FavouriteBookList()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Улюблене")
                }.tag(2)
           
        }
        
    }
        
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
