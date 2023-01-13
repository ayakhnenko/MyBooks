//
//  Date.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 22.11.2022.
//

import Foundation


extension Date {
    
    init(fromEpoch: Int) {
           let doubleValue = Double(fromEpoch)
           self = Date(timeIntervalSince1970: doubleValue)
       }

    var monthName : String {
           let formatter = DateFormatter()
           formatter.locale = Locale.init(identifier: "ua")
           formatter.dateFormat = "MMMM yyyy"
           return formatter.string(from: self)
       }

}
 
