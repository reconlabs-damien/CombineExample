//
//  Chapter11.swift
//  CombineExample
//
//  Created by Jun on 2022/03/29.
//

import SwiftUI


struct Chapter11: View {
    var body: some View {
        ScrollView {
            HStack(spacing: 16) {
                VStack {
                    ForEach(Array(leftCards.enumerated()), id: \.element) { offset, card in
                        CellView(card: card)
                            .frame(height: offset % 2 == 0 ? 320 : 200)
                    }
                }
                
                VStack {
                    ForEach(Array(rightCards.enumerated()), id: \.element) { offset, card in
                        CellView(card: card)
                            .frame(height: offset % 2 != 0 ? 320 : 200)
                    }
                }
            }.padding()
        }.navigationTitle("Categories")
            .navigationBarItems(leading: Button(action: {
                
            }, label: {
                Image(systemName: "arrow.backward")
            }), trailing: Button(action: {
                
            }, label: {
                Image(systemName: "magnifyingglass")
            }))
    }
}

struct Sport: Hashable {
    let title: String
    let imageName: String
}

let leftCards:[Sport] = [
    .init(title: "Kick Boxing", imageName: "kickboxing"),
    .init(title: "Boxing", imageName: "boxing"),
    .init(title: "Morning", imageName: "yoga"),
    .init(title: "Fitness", imageName: "interval")
]

let rightCards:[Sport] = [
    .init(title: "Pilates", imageName: "yoga"),
    .init(title: "Intervals", imageName: "interval"),
    .init(title: "Yoga", imageName: "pilates"),
    .init(title: "Run", imageName: "boxing")
]

struct CellView: View {
    
    let card:Sport
    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack {
                Image(card.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .clipped()
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).fill(Color.gray).opacity(0.4))
                
                Text(card.title.uppercased())
                    .font(.title3)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(8)
                    .foregroundColor(.white)
            }
            
        }
        
    }
}

struct Chapter11_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Chapter11()
        }.accentColor(.primary)
    }
}
