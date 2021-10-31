//
//  SuiApp3App.swift
//  SuiApp3
//
//  Created by Александр Вяткин on 18.09.2021.
//

import SwiftUI

@main
struct SuiApp3App: App {
    @State var selectedTab = 2
    var body: some Scene {
        WindowGroup {
            MainScreen(apiChoice: self.$selectedTab).onOpenURL { url in
                if url.host == "link1" {
                    self.selectedTab = 0
                } else if url.host == "link2" {
                    selectedTab = 3
                }
            }
        }
    }
}
