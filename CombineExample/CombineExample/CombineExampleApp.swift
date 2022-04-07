//
//  CombineExampleApp.swift
//  CombineExample
//
//  Created by Jun on 2022/02/21.
//

import SwiftUI

@main
struct CombineExampleApp: App {
    
    @StateObject private var wallet = Wallet()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                Chapter14()
            }.accentColor(.primary)
        }
        
    }
    
}
