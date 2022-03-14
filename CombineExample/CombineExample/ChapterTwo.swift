//
//  ChapterTwo.swift
//  CombineExample
//
//  Created by Jun on 2022/03/14.
//

import SwiftUI

struct ChapterTwo: View {
    
    private var numberOfImages = 5
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @State private var currentIndex = 0
    
    
    var controls: some View {
        HStack {
            Button {
                currentIndex = currentIndex > 0 ? currentIndex - 1 : 0
            } label: {
                Image(systemName: "chevron.left")
            }
            
            Spacer().frame(width: 100)
            
            Button {
                currentIndex = currentIndex < numberOfImages ? currentIndex + 1 : 0
            } label: {
                Image(systemName: "chevron.right")
            }
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            TabView(selection: $currentIndex) {
                ForEach(0..<numberOfImages) { num in
                    Image(systemName: "gear")
                        .resizable()
                        .scaledToFill()
                        .overlay(Color.black.opacity(0.4))
                        .tag(num)
                }
            }.tabViewStyle(PageTabViewStyle())
                .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding()
            .frame(width: proxy.size.width, height: proxy.size.height / 3)
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = currentIndex < numberOfImages ? currentIndex + 1 : 0
                }
                
            }
            controls
        }
    }
}

struct ChapterTwo_Previews: PreviewProvider {
    static var previews: some View {
        ChapterTwo()
    }
}
 
