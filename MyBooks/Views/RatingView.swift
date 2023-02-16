//
//  RatingView.swift
//  MyBooks
//
//  Created by Alisa Yakhnenko on 13.01.2023.
//

import SwiftUI

struct RatingView: View {
    @Binding var range: Int
    
    var label = ""
    var maximumRange = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            ForEach(0..<maximumRange, id:\.self) { number in
                image(for: number)
                    .foregroundColor(number > range ? offColor : onColor)
                    .onTapGesture {
                        range = number
                    }
            }
        }
    }
    func image(for number: Int) -> Image {
        if number > range {
            return offImage ?? onImage
        } else {
                return onImage
            }
        }
    }


struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(range: .constant(4))
    }
}
