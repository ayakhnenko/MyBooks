//
//  NavigationStorage.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 15.03.2023.
//

import SwiftUI

/// Хранилище стека
final class NavigationStorage: ObservableObject {
    
    static let shared = NavigationStorage()
    
   
   @Published var path = NavigationPath()
    

}
