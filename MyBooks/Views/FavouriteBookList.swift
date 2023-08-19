////
////  FavouriteBookList.swift
////  MyBooks
////
////  Created by Alisa Yakhnenko on 20.11.2022.
////
//
//import SwiftUI
//
//
//struct FavouriteBookList: View {
//    
//    @Environment(\.managedObjectContext) var viewContext
//    @ObservedObject var vm: BookListViewModel
//   // @StateObject private var storage = NavigationStorage()
//    init(vm: BookListViewModel) {
//        self.vm = vm
//    }
//    
//    @State private var showingAddBook = false
//    
//    var body: some View {
//       
//            NavigationStack/*(path: $storage.path)*/ {
//                List {
//                    ForEach(vm.favBooks) { book in
////                        Button {
////                            vm.selectModelIntent(book: book)
////                        } label: {
//                            HStack {
//                                Image(uiImage: book.image)  
//                                    .resizable()
//                                    .scaledToFit()
//                                    .edgesIgnoringSafeArea(.all)
//                                    .frame(width: 90, height: 90)
//                                    .shadow(radius: 10)
//                                
//                                VStack(alignment: .leading, spacing: 6) {
//                                    Text(book.name)
//                                        .bold()
//                                    Text(book.author)
//                                        .italic()
//                                        .foregroundColor(.gray)
//                                }
//                                Spacer()
//                                if book.readingNow {
//                                    Text("👀")
//                                }
//                                if book.isFavourite {
//                                    Text("❤️")
//                                }
//                            }
//                        //}
//                    }
//                }.listStyle(.plain)
////                    .navigationDestination(for: BookViewModel.self) { [weak vm] book in
////                        if let detailBookViewModel = vm?.detailBookViewModel {
////                            EditBookView(vm: detailBookViewModel)
////                        }
////                    }
//                    .navigationTitle("Мої улюблені книжечки")
//                    .navigationViewStyle(.stack)
//            }
//        }
//    }
//
//    //
//    //        private func deleteBook(offsets: IndexSet) {
//    //            withAnimation {
//    //                offsets.map { book[$0] }.forEach(viewContext.delete)
//    //                DataController().save()
//    //            }
//    //        }
//    
//    
//    
//    
//    //struct FavouriteBookList_Previews: PreviewProvider {
//    //    static var previews: some View {
//    //        FavouriteBookList()
//    //    }
//    //}
