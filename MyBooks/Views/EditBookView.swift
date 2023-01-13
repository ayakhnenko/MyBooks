//
//  EditBookView.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 03.10.2022.
//

import SwiftUI

struct EditBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    var book: FetchedResults<Book>.Element
    
    @State private var name = ""
    @State private var author = ""
    @State private var comments = ""
    @State private var startDate = Date()
    @State private var finishDate = Date()
    @State private var isFavourite = false
    @State private var range = 0.0
    @State private var image = UIImage(imageLiteralResourceName: "boy")
    @State private var readingNow = false
    @State private var imagePicker = false
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Image(uiImage: UIImage(data: book.image!)!)
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: 90, height: 90)
                        .shadow(radius: 10)
                        .padding(15)
                        .onAppear {
                            image = UIImage(data: book.image!)!
                        }
                    Button {
                        imagePicker.toggle()
                    } label: {
                        Text("Змінити світлину")
                    }.sheet(isPresented: $imagePicker) {
                        ImagePickerView(selectedImage: $image)
                    }
                }
            }
            Section {
                TextField("\(book.name!)", text: $name)
                    .onAppear {
                        name = book.name!
                    }
                TextField("\(book.author!)", text: $author)
                    .onAppear {
                        author = book.author!
                    }
                
                TextEditor(text: $comments)
                    .onAppear {
                        comments = book.comments ?? ""
                    }
                    .lineLimit(nil)
            }
            Section {
                DatePicker("Початок читання", selection: $startDate, displayedComponents: [.date])
                    .onAppear {
                        startDate = book.startDate ?? Date()
                    }
                DatePicker("Кінець читання", selection: $finishDate, displayedComponents: [.date])
                    .onAppear {
                        finishDate = book.finishDate ?? Date()
                    }
            }
            Section {
                Toggle(isOn: $readingNow) {
                    Text("Читаю зараз")
                }.onAppear {
                    readingNow = book.readingNow
                }
                VStack {
                    Toggle(isOn: $isFavourite) {
                        Text("Улюблена книжечка ❤️")
                    }
                    .onAppear {
                        isFavourite = book.isFavourite
                    }
                    
                    Text("Оцінка: \(Int(range))")
                    Slider(value: $range, in: 0...5, step: 1)
                }
                .onAppear {
                    range = Double(book.range)
                }
                .padding()
            }
            Section {
                HStack {
                    Spacer()
                    Button("Зберегти 📚") {
                        DataController().editBook(book: book, name: name, image: image, author: author, startDate: startDate, comments: comments, finishDate: finishDate, isFavourite: isFavourite, readingNow: readingNow, range: Int(range), context: moc)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

