//
//  AddBookView.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 03.10.2022.
//
import SwiftUI
import CoreData


struct AddBookView: View {
    
   @ObservedObject var detailBookVM: DetailBookViewModel
   
    init(vm: DetailBookViewModel) {
        self.detailBookVM = vm
    }
   
   // @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
   
   
    @State private var imagePicker = false
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Image(uiImage: detailBookVM.image)
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
                        ImagePickerView(selectedImage: $detailBookVM.image)
                    }
                }
            }
            Section {
                VStack {
                    HStack {
                        Text("Назва книги")
                        TextField("", text: $detailBookVM.name)
                    }
                    HStack {
                        Text("Писменник")
                        TextField("", text: $detailBookVM.author)
                    }
                    HStack {
                        Text("Коментар:")
                        TextEditor(text: $detailBookVM.comments)
                            .lineLimit(nil)
                    }
                }.padding()
            }
            Section {
                DatePicker("Початок читання", selection: $detailBookVM.startDate, displayedComponents: [.date])
                DatePicker("Кінець читання", selection: $detailBookVM.finishDate, displayedComponents: [.date])
                }
            Section {
                Toggle("Читаю зараз", isOn: $detailBookVM.readingNow)
                Toggle(("Улюблена книга ❤️"), isOn: $detailBookVM.isFavourite)
                HStack {
                    Spacer()
                    RatingView(range: $detailBookVM.range)
                    Spacer()
                }
            }
            Section {
               HStack {
                    Spacer()
                   Button("Зберегти 📚") {
                       detailBookVM.addBook(name: detailBookVM.name, image:  detailBookVM.image, author:  detailBookVM.author, startDate:  detailBookVM.startDate, comments:  detailBookVM.comments, finishDate:  detailBookVM.finishDate, isFavourite:  detailBookVM.isFavourite, range: Int16( detailBookVM.range), readingNow:  detailBookVM.readingNow)
                       self.dismiss()
                       
                   }
                   Spacer()
            
               }
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = DataController.shared.container.viewContext
        AddBookView(vm: DetailBookViewModel(context: viewContext))
    }
}
