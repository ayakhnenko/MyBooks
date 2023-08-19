////
////  BookList2.swift
////  MyBooks
////
////  Created by Alisa Yakhnenko on 16.03.2023.
////
//
//import SwiftUI
//
//struct BookList2: View {
//    @Environment(\.managedObjectContext) var viewContext
//    @Environment(\.dismiss) var dismiss
//    @StateObject var storage = NavigationStorage.shared
//    
//    var columns = [GridItem(.adaptive(minimum: 160), spacing: 5)]
//    @State public var showingAddBook = false
//    @ObservedObject var vm: BookListViewModel
//    
//    
//    var body: some View {
//       
//        NavigationStack(path: $storage.path) {
//            
//                ScrollView {
//                    
//                    Section {
//                        
//                        ForEach(vm.arrayYears, id: \.self) { year in
//                            HStack {
//                                Text("\(year) рік")
//                                    .foregroundColor(.gray)
//                                    .padding(10)
//                                    
//                                Text("- \(vm.bookCounter(year: year))  прочитано")
//                                    .foregroundColor(.gray)
//                                
//                                
//                            }.padding()
//                                .frame(width: 300, height: 30)
//                                .shadow(color: .mint, radius: 10, x: 10, y: 10)
//                                .cornerRadius(20)
//                           LazyVGrid(columns: columns, spacing: 10) {
//                                ForEach(vm.books, id: \.self) { book in
//                                    
//                                  if book.finishDate.dateYear() == year {
//                                        
//                                        Button {
//                                            vm.selectModelIntent(book: book)
//                                        } label: {
//                                            BookCard(book: book)
//                                        }
//                                  } else {
//                                      
//                                  }
//                                }
//                                .padding()
//                                
//                            }
//                        }
//                    }
//                }.navigationDestination(for: BookViewModel.self) { [weak vm]  book in
//                    if let detailBookViewModel = vm?.detailBookViewModel {
//                        EditBookView(vm: detailBookViewModel)
//                    }
//                }
//                .navigationTitle("Книги")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button {
//                           showingAddBook = true
//                          
//                        } label: {
//                            Label("", systemImage: "plus.circle")
//                                .foregroundColor(.mint)
//                                .cornerRadius(50)
//                        }
//                    }
//                    
//           }.sheet(isPresented: $showingAddBook) {
//              
//                    AddBookView(vm: DetailBookViewModel(context: viewContext))
//                    }
//                    
//            
//                Spacer()
//            
//        }
//    }
//    
//}
//
//
//struct BookCard: View {
// let book: BookViewModel
//    
//    var body: some View {
//      
//        ZStack(alignment: .bottom) {
//              Color.mint.opacity(0.7)
//                        .frame(width: 160, height: 220)
//                        .cornerRadius(30)
//              VStack {
//                  HStack {
//                      if book.isFavourite {
//
//                          Text("❤️")
//                          Spacer()
//
//                      }
//                      if book.readingNow {
//                          Spacer()
//                          Text("👀")
//                      }
//
//                  }.padding(.top, 15)
//                      .padding(.horizontal, 15)
//                      .frame(width: 160, height: 30)
//
//                  Image(uiImage: book.image)
//                      .resizable()
//                      .scaledToFit()
//                      .edgesIgnoringSafeArea(.all)
//                      .cornerRadius(10)
//                      .frame(width: 160)
//                     
//                      
//                  VStack {
//                      Text("\(book.startDate.dateFormatter())")
//                          .foregroundColor(Color.gray)
//                      if book.readingNow {
//                          Text("...").padding(.bottom)
//                              .foregroundColor(Color.gray)
//                      } else {
//                          Text("\(book.finishDate.dateFormatter())")
//                              .foregroundColor(Color.gray)
//                              .padding(.bottom, 10)
//                      }
//                  }
//                      .padding(6)
//                      .frame(width: 154)
//                      .background(Color.white.opacity(0.2))
//                      .cornerRadius(20)
//                      
//              }.frame(width: 160, height: 220)
//                    }
//            .cornerRadius(30)
//                }
//            }
//       
//    
//
