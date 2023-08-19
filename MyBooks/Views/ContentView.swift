//
//  ContentView.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 03.10.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
  
    @Environment(\.managedObjectContext) var viewContext
    let views = ["Книжки", "Улюблені книжки"]
    
    @State private var selectedView: Int = 0
    
    var body: some View {
        
        VStack {
            Picker(selection: $selectedView, label: Text("")) {
                ForEach(0..<2) { view in
                    Text(self.views[view])
                }
            }.pickerStyle(SegmentedPickerStyle())
                .padding(5)
            
            
            if selectedView == 0 {
                BookList(vm: BookListViewModel(context: viewContext))
                
            }
            else if selectedView == 1 {
                FavouriteBookList2(vm: BookListViewModel(context: viewContext))
            }
            
        }.background(Color.mint)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
