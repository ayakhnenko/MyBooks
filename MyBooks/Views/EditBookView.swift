//
//  EditBookView.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 03.10.2022.
//

import SwiftUI

struct EditBookView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: BookListViewModel
    var book: BookModel
   @State private var imagePicker = false
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Image(uiImage: book.image)
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: 90, height: 90)
                        .shadow(radius: 10)
                        .padding(15)
                        .onAppear {
                            vm.image = book.image
                            
                        }
                    Button {
                        imagePicker.toggle()
                    } label: {
                        Text("Змінити світлину")
                    }.sheet(isPresented: $imagePicker) {
                        ImagePickerView(selectedImage: $vm.image)
                    }
                }
            }
            Section {
                TextField((book.name), text: $vm.name)
                    .onAppear {
                        vm.name = book.name
                    }
                TextField((book.author), text: $vm.author)
                    .onAppear {
                        vm.author = book.author
                    }
                
                TextEditor(text: $vm.comments)
                    .onAppear {
                        vm.comments = book.comments
                    }
                    .lineLimit(nil)
            }
            Section {
                DatePicker("Початок читання", selection: ($vm.startDate), displayedComponents: [.date])
                    .onAppear {
                        vm.startDate = book.startDate
                    }
                DatePicker("Кінець читання", selection: $vm.finishDate, displayedComponents: [.date])
                    .onAppear {
                        vm.finishDate = book.finishDate
                    }
            }
            Section {
                Toggle("Читаю зараз", isOn: $vm.readingNow)
                    .onAppear {
                        vm.readingNow = book.readingNow
                    }
                    Toggle("Улюблена книга ❤️", isOn: $vm.isFavourite)
                        .onAppear {
                            vm.isFavourite = book.isFavourite
                        }
                Toggle("Не дочитала", isOn: $vm.isNotFinish)
                    .onAppear {
                        vm.isNotFinish = book.isNotFinish
                    }
                HStack {
                    Spacer()
                    RatingView(range: $vm.range)
                        .onAppear {
                            vm.range = Int(book.range)
                        }
                    Spacer()
                }
                    

            }
            
            Section {
                HStack {
                    Spacer()
                    Button("Зберегти 📚") {
                        vm.editBook(book: book.book, name: vm.name, image: vm.image, author: vm.author, startDate: vm.startDate, comments: vm.comments, finishDate: vm.finishDate, isFavourite: vm.isFavourite, readingNow: vm.readingNow, range: Int(vm.range), isNotFinish: vm.isNotFinish)
                        self.dismiss()
                        
                    }
                    Spacer()
                }
            }
//            Section {
//                HStack {
//                    Spacer()
//                    Button {
//                        vm.deleteBook(bookId: (vm.book.id))
//                        vm.dismiss()
//                    } label: {
//                        Image(systemName: "trash")
//                            .foregroundColor(.red)
//                    }
//                    Spacer()
//
//
//                }
//            }
        }
    }
}

