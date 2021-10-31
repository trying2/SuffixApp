//
//  MainScreen.swift
//  MainScreen
//
//  Created by Александр Вяткин on 18.09.2021.
//

import SwiftUI
import AppUI
import Networking

struct MainScreen: View {
    @StateObject var movieViewModel: MovieViewModel = .init()
    @Binding var apiChoice: Int
    var apiList = ["iOS news", "Movie week", "Animation", "SuffixSequence"]
    
    var body: some View {
        NavControllerView(transition: .custom(.moveAndFade)) {
            VStack {
                Picker("Options", selection: $apiChoice) {
                    ForEach(0 ..< apiList.count) { index in
                        Text(self.apiList[index])
                            .tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                
                Spacer()
                
                switch apiChoice {
                case 0:
                    NewsScreen()
                case 1:
                    MovieTrandingScreen()
                case 2:
                    AnimationScreen()
                case 3:
                    SuffixScreen()
                    
                default:
                    NewsScreen()
                }
            }
        }.onOpenURL { url in
            print(url)
        }
    }
}
