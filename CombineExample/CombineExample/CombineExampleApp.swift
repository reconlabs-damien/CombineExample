//
//  CombineExampleApp.swift
//  CombineExample
//
//  Created by Jun on 2022/02/21.
//

import SwiftUI

@main
struct CombineExampleApp: App {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    ChapterThree()
                }
            }.tabItem {
                Image(systemName: "list.bullet")
                Text("List")
            }
            
            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .environment(\.colorScheme, isDarkMode ? .dark : .light)
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .accentColor(.primary)
        }
        
    }
    
}
