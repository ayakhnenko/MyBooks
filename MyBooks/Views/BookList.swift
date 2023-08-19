////
////  BookList.swift
////  MyBooks
////
////  Created by Alisa Yakhnenko on 20.11.2022.
////
//
import SwiftUI

struct BookList: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @State private var showingAddBook = false
    @StateObject var storage = NavigationStorage.shared
    @ObservedObject var vm: BookListViewModel
    
    
//    init(vm: BookListViewModel) {
//        self.vm = vm
//    }
    
    
        private func deleteBook(at offsets: IndexSet) {
            offsets.forEach { index in
                let book = vm.books[index]
                vm.deleteBook(bookId: book.id)
            }
        }
    var body: some View {
        NavigationStack(path: $storage.path) {
            List {
                Section {
                    ForEach(vm.arrayYears, id: \.self) { year in
                        HStack {
                            Text("\(year) рік")
                                .foregroundColor(.gray)
                                .padding(10)
                            
                            Text("- \(vm.bookCounter(year: year))  прочитано")
                                .foregroundColor(.gray)
                            
                        }.padding()
                            .frame(width: 300, height: 30)
                            .shadow(color: .mint, radius: 10, x: 10, y: 10)
                            .cornerRadius(20)
                        
                        ForEach(vm.books, id: \.self) { book in
                            if book.finishDate.dateYear() == year {
                                Button {
                                    vm.selectModelIntent(book: book)
                                } label: {
                                    BookCard(book: book)
                                }
                            }
                        }.onDelete(perform: deleteBook)
                    }
                    }
                    }.listStyle(.plain)
                        .navigationDestination(for: BookModel.self) {  book in
//                            if let detailBookViewModel = vm?.detailBookViewModel {
                            EditBookView(vm: self.vm, book: book)
                        //    }
                        }
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
                        }.foregroundColor(.mint)
                        .sheet(isPresented: $showingAddBook) {
                            AddBookView(vm: self.vm) //DetailBookViewModel(context: viewContext, parent: self.vm ))
                        }
                        .navigationViewStyle(.stack)
                }
            }
        }
    



struct BookCard: View {
    let book: BookModel
    
    var body: some View {
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
                
                Text(book.startDate.dateFormatter())
                    .foregroundColor(.gray)
                if book.readingNow {
                    Text("...").foregroundColor(Color.gray)
                } else {
                    Text("\(book.finishDate.dateFormatter())")
                        .foregroundColor(Color.gray)
                }
            }
            Spacer()
            if book.readingNow {
                Text("👀")
            }
           else if book.isFavourite {
                Text("❤️")
           } else if book.isNotFinish {
               Text("⛔️")
           }
        }.padding()
    }
}
