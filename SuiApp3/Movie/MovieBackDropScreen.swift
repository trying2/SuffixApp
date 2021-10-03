//
//  MovieBackDropScreen.swift
//  MovieBackDropScreen
//
//  Created by Александр Вяткин on 19.09.2021.
//

import SwiftUI
import AppUI
import SDWebImageSwiftUI

struct MovieBackDropScreen: View {
    var imagePath: String
    
    var body: some View {
        VStack {
            HStack {
                NavPopButton(destination: .previous) {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Spacer()
                    }.padding()
                }
            }
            WebImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(imagePath)"))
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
