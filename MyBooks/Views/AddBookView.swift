//
//  AddBookView.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 03.10.2022.
//
import SwiftUI
import CoreData


struct AddBookView: View {
    
   @ObservedObject var vm: BookListViewModel
    
//    init(vm: DetailBookViewModel) {
//        self.vm = vm
//    }
   
    @Environment(\.dismiss) var dismiss
    @State private var imagePicker = false
   
    var body: some View {
        Form {
            Section {
                HStack {
                    Image(uiImage: vm.image)
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
                        ImagePickerView(selectedImage: $vm.image)
                    }
                }
            }
            Section {
                VStack {
                    HStack {
                        Text("Назва книги")
                        TextField("", text: $vm.name)
                    }
                    HStack {
                        Text("Писменник")
                        TextField("", text: $vm.author)
                    }
                    HStack {
                        Text("Коментар:")
                        TextEditor(text: $vm.comments)
                            .lineLimit(nil)
                    }
                }.padding()
            }
            Section {
                DatePicker("Початок читання", selection: $vm.startDate, displayedComponents: [.date])
                DatePicker("Кінець читання", selection: $vm.finishDate, displayedComponents: [.date])
                }
            Section {
                Toggle("Читаю зараз", isOn: $vm.readingNow)
                Toggle(("Улюблена книга ❤️"), isOn: $vm.isFavourite)
                Toggle("Не дочитала", isOn: $vm.isNotFinish)
                HStack {
                    Spacer()
                    RatingView(range: $vm.range)
                    Spacer()
                }
            }
            Section {
               HStack {
                    Spacer()
                   Button("Зберегти 📚") {
                       vm.addBook(name: vm.name, image:  vm.image, author:  vm.author, startDate:  vm.startDate, comments:  vm.comments, finishDate:  vm.finishDate, isFavourite:  vm.isFavourite, range: Int16(vm.range), readingNow:  vm.readingNow, isNotFinish: vm.isNotFinish)
                       
                     self.dismiss()
                      
                   }
                   Spacer()
            
               }
            }
        }
    }
}

