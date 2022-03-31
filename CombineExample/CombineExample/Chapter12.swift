//
//  Chapter12.swift
//  CombineExample
//
//  Created by Jun on 2022/03/31.
//

import SwiftUI

struct Chapter12: View {
    
    @State private var searchText = ""
    
    init() {
        UINavigationBar.appearance()
            .setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        UINavigationBar.appearance().shadowImage = UIImage()
        
        UINavigationBar.appearance().isTranslucent = false
        
        UINavigationBar.appearance().barTintColor = .systemGroupedBackground
    }
    
    var searchView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25).fill(Color(.systemGray5))
                .frame(height: 50)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color(.systemGray4))
                    .padding(.horizontal, 20)
                
                TextField("Search themes here", text: $searchText)
                    .font(.custom("Avenir-Medium", size: 16))
                
                Image(systemName: "mic")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.horizontal, 20)
                    .foregroundColor(Color(.systemRed))
            }
            
        }.padding(.vertical, 50)
            .padding(.horizontal, 20)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Welcome Back Herald")
                    .font(.custom("Avenir-Heavy", size: 30))
                Text("Ready to start your day?")
                    .font(.custom("Avenir-Medium", size: 18))
                    .foregroundColor(Color(.systemGray))
                searchView
            }.padding(24)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button {
            
        } label: {
            Image(systemName: "list.bullet")
        }, trailing: Button {
            
        } label: {
            Image(systemName: "bell")
        })
    }
}

struct Chapter12_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Chapter12()
        }
        
    }
}
