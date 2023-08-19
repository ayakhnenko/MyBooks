//
//  FavouriteBookList2.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 19.03.2023.
//

import SwiftUI

struct FavouriteBookList2: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var vm: BookListViewModel
    @StateObject private var storage = NavigationStorage.shared

    @State private var showingAddBook = false
    
    var body: some View {
        NavigationStack(path: $storage.path) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    ForEach(vm.favBooks, id: \.self) { book in

                            GeometryReader { geometry in
                                BigBookCard(book: book)
                                    .rotation3DEffect(Angle(degrees: geometry.frame(in: .global).minY - 120) / 20, axis: (x: 10, y: 0, z: 0))
                            }.frame(width: 260, height: 290)
                       
                    }
                }
                .padding()
           }
            
            .navigationTitle("Улюблені книги")

        }
        Spacer()
    }
}




struct BigBookCard: View {
    let book: BookModel
    
    var body: some View {
        ZStack {
            Color.mint.opacity(0.2)
                .frame(width: 260, height: 290)
                .cornerRadius(30)
            VStack {
                Image(uiImage: book.image)
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                    .padding(20)
                    .frame(width: 190, height: 190)
                    .cornerRadius(30)
                Text(book.startDate.dateFormatter()).foregroundColor(.gray)
                Text(book.finishDate.dateFormatter()).foregroundColor(.gray)
            }
        }
    }
}
