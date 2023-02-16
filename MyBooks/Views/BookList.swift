//
//  BookList.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 20.11.2022.
//

import SwiftUI
import CoreData


//        @FetchRequest(sortDescriptors: [SortDescriptor(\.finishDate, order: .reverse)]) var books: FetchedResults<Book>


struct BookList: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @State private var showingAddBook = false
    
    @ObservedObject var bookListVM: BookListViewModel
    
    
    init(vm: BookListViewModel) {
        self.bookListVM = vm
    }
   
    
    private func deleteBook(at offsets: IndexSet) {
        offsets.forEach { index in
            let book = bookListVM.books[index]
            bookListVM.deleteBook(bookId: book.id)
        }
    }
        var body: some View {
            NavigationView {
                VStack {
                    List {
                        ForEach(bookListVM.books) { book in
                            NavigationLink(destination: EditBookView(vm: DetailBookViewModel(context: viewContext, book: book))) {
                                HStack {
                                    Image(uiImage: book.image)
                                            .resizable()
                                            .scaledToFit()
                                            .edgesIgnoringSafeArea(.all)
                                            .frame(width: 90, height: 90)
                                            .shadow(radius: 10)
                                        
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(book.name)
                                                .bold()
                                            Text(book.author)
                                                .italic()
                                                .foregroundColor(.gray)
                                            Text("\(book.startDate.dateFormatter())  -  \(book.finishDate.dateFormatter())")
                                                .foregroundColor(.gray)
                                            
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
                        .navigationTitle("Мої книжечки")
                    
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    showingAddBook.toggle()
                                } label: {
                                    Label("Add book", systemImage: "plus.circle")
                                }
                            }
                            ToolbarItem(placement: .navigationBarLeading) {
                                EditButton()
                            }
                        }
                        .sheet(isPresented: $showingAddBook) {
                            AddBookView(vm: DetailBookViewModel(context: viewContext ))
                        }
                        .navigationViewStyle(.stack)
                }
            }
        }
        
    }


struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = DataController.shared.container.viewContext
        BookList(vm: BookListViewModel(context: viewContext))
    }
}
