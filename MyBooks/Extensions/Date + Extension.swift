//
//  Date + Extension.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 13.02.2023.
//

import Foundation


extension Date {
    
    func dateFormatter() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "dd-MM-yy"
        
        let toString = dateFormatter.string(from: self)
        return toString
    }
    
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
    
    func dateYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "YYYY"
        let yearToString = dateFormatter.string(from: self)
        return yearToString
    }

}
