//
//  EditBookView.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 03.10.2022.
//

import SwiftUI

struct EditBookView: View {
    
    @ObservedObject private var detailBookVM: DetailBookViewModel
    //@ObservedObject var book: Book
    
    init(vm: DetailBookViewModel) {
         self.detailBookVM = vm
     }
   
   @Environment(\.managedObjectContext) var viewContext
   @Environment(\.dismiss) var dismiss

   // var book: FetchedResults<Book>.Element
    

   @State private var imagePicker = false

    var body: some View {
       VStack {
            Section {
                HStack {
                    Image(uiImage: detailBookVM.image)
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: 90, height: 90)
                        .shadow(radius: 10)
                        .padding(15)
                        .onAppear {
                            detailBookVM.image = UIImage(data: (detailBookVM.book!.image!))!
                        }
                    Button {
                        imagePicker.toggle()
                    } label: {
                        Text("Змінити світлину")
                    }.sheet(isPresented: $imagePicker) {
                        ImagePickerView(selectedImage: $detailBookVM.image)
                    }
                }
            }
            Section {
                TextField((detailBookVM.book!.name)!, text: $detailBookVM.name)
                    .onAppear {
                        detailBookVM.name = detailBookVM.book!.name ?? ""
                    }
                TextField((detailBookVM.author), text: $detailBookVM.author)
                    .onAppear {
                        detailBookVM.author = detailBookVM.book?.author ?? ""
                    }
                
                TextEditor(text: $detailBookVM.comments)
                    .onAppear {
                        detailBookVM.comments = detailBookVM.book?.comments ?? ""
                    }
                    .lineLimit(nil)
            }
            Section {
                DatePicker("Початок читання", selection: ($detailBookVM.startDate), displayedComponents: [.date])
                    .onAppear {
                        detailBookVM.startDate = detailBookVM.book?.startDate ?? Date()
                    }
                DatePicker("Кінець читання", selection: $detailBookVM.finishDate, displayedComponents: [.date])
                    .onAppear {
                        detailBookVM.finishDate = detailBookVM.book?.finishDate ?? Date()
                    }
            }
            Section {
                Toggle(isOn: $detailBookVM.readingNow) {
                    Text("Читаю зараз")
                }.onAppear {
                    detailBookVM.readingNow = detailBookVM.book!.readingNow
                }
                VStack {
                    Toggle(isOn: $detailBookVM.isFavourite) {
                        Text("Улюблена книга ❤️")
                    }
                    .onAppear {
                        detailBookVM.isFavourite = detailBookVM.book!.isFavourite
                    }
                    RatingView(range: $detailBookVM.range)
                    .onAppear {
                        detailBookVM.range = Int(detailBookVM.book!.range)
                    }
                }
                .padding()
            }
      
            Section {
                HStack {
                    Spacer()
                    Button("Зберегти 📚") {
                        detailBookVM.editBook(book: detailBookVM.book!, name: detailBookVM.name, image: detailBookVM.image, author: detailBookVM.author, startDate: detailBookVM.startDate, comments: detailBookVM.comments, finishDate: detailBookVM.finishDate, isFavourite: detailBookVM.isFavourite, readingNow: detailBookVM.readingNow, range: Int(detailBookVM.range))
                        self.dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

//struct EditBookView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewContext = DataController.shared.container.viewContext
//        EditBookView(vm: EditBookViewModel(context: viewContext), book: book)
//    }
//}
