//
//  AddBookView.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 03.10.2022.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var author = ""
    @State private var comments = ""
    @State private var startDate = Date()
    @State private var finishDate = Date()
    @State private var isFavourite = false
    @State private var range = 0.0
    @State private var image = UIImage(imageLiteralResourceName: "boy")
    @State private var imagePicker = false
    @State private var readingNow = false
    
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: 90, height: 90)
                        .shadow(radius: 10)
                        .padding(15)
                    Button(action: {
                        imagePicker.toggle()
                    }, label: {
                        Text("Додати світлину")
                    })
                    .sheet(isPresented: $imagePicker) {
                        ImagePickerView(selectedImage: $image)
                    }
                }
            }
            Section {
                VStack {
                    TextField("Назва книжечки", text: $name)
                    TextField("Писменник", text: $author)
                    TextEditor(text: $comments)
                        .lineLimit(nil)
                }.padding()
            }
            Section {
                    DatePicker("Початок читання", selection: $startDate, displayedComponents: [.date])
                    DatePicker("Кінець читання", selection: $finishDate, displayedComponents: [.date])
                }
            Section {
                    Toggle("Читаю зараз", isOn: $readingNow)
                    Toggle(("Улюблена книжечка ❤️"), isOn: $isFavourite)
                
                VStack {
                    Text("Оцінка: \(Int(range))")
                    Slider(value: $range, in: 0...5, step: 1)
                }
                .padding()
            }
            Section {
               HStack {
                    Spacer()
                    Button("Зберегти 📚") {
                        DataController().addBook(name: name, image: image, author: author, startDate: startDate, comments: comments, finishDate: finishDate, isFavourite: isFavourite, range: Int16(range), readingNow: readingNow, context: moc)
                        dismiss()
                    }
                    Spacer()
            
                }
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
