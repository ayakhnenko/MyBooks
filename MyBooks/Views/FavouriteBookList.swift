//
//  FavouriteBookList.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 20.11.2022.
//

import SwiftUI
import CoreData

struct FavouriteBookList: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isFavourite == true")) var book: FetchedResults<Book>
    
    @State private var showingAddBook = false
    
       
        
        var body: some View {
            NavigationView {
                List {
                    ForEach(book) { book in
                        NavigationLink(destination: EditBookView(book: book)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(uiImage: UIImage(data: book.image!) ?? UIImage(imageLiteralResourceName: "boy"))
                                            .resizable()
                                            .scaledToFit()
                                            .edgesIgnoringSafeArea(.all)
                                            .frame(width: 90, height: 90)
                                            .shadow(radius: 10)
                                        
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(book.name ?? "")
                                                .bold()
                                            Text(book.author ?? "")
                                                .italic()
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                Spacer()
                                if book.readingNow {
                                    Text("👀")
                                }
                                if book.isFavourite {
                                    Text("❤️")
                                    }
                            }
                        }
                    }.onDelete(perform: deleteBook)
                }.listStyle(.plain)
                    .navigationTitle("Мої улюблені книжечки")
                    .navigationViewStyle(.stack)
            }
            
        }
        
        
        private func deleteBook(offsets: IndexSet) {
            withAnimation {
                offsets.map { book[$0] }.forEach(moc.delete)
                DataController().save(context: moc)
            }
        }
    }



struct FavouriteBookList_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteBookList()
    }
}
