//
//  Chapter11.swift
//  CombineExample
//
//  Created by Jun on 2022/03/29.
//

import SwiftUI


struct Chapter11: View {
    
    let cards:[Sport] = [
        .init(title: "Pilates", imageName: "yoga"),
        .init(title: "Intervals", imageName: "interval"),
        .init(title: "Yoga", imageName: "pilates"),
        .init(title: "Run", imageName: "boxing"),
        .init(title: "Kick Boxing", imageName: "kickboxing"),
        .init(title: "Boxing", imageName: "boxing"),
        .init(title: "Morning", imageName: "yoga"),
        .init(title: "Fitness", imageName: "interval")
    ]
    
    var leftCards:[Sport] {
        cards.enumerated()
            .filter { $0.offset % 2 == 0 }
            .map { $0.element }
    }
    var rightCards:[Sport] {
        cards.enumerated()
            .filter { $0.offset % 2 != 0 }
            .map { $0.element }
    }
    
    var visibleLeftCards:[Sport] {
        if cards.count % 2 != 0, cards.count != 1 {
            let slice = ArraySlice(leftCards[0...leftCards.count - 1])
            return Array(slice)
        } else {
            return leftCards
        }
    }
    
    var visibleRightCards:[Sport] {
        if cards.count % 2 != 0, let lastLeftCard = leftCards.last, cards.count != 1 {
            return rightCards + [lastLeftCard]
        } else {
            return rightCards
        }
    }
    
    var body: some View {
        ScrollView {
            HStack(spacing: 16) {
                VStack {
                    ForEach(Array(visibleLeftCards.enumerated()), id: \.element) { offset, card in
                        CellView(card: card)
                            .frame(height: offset % 2 == 0 ? 320 : 200)
                    }
                    Spacer()
                }
                
                VStack {
                    if cards.count == 1 {
                        RoundedRectangle(cornerRadius: 10).fill(Color.clear)
                    }
                    ForEach(Array(visibleRightCards.enumerated()), id: \.element) { offset, card in
                        CellView(card: card)
                            .frame(height: offset % 2 != 0 ? 320 : 200)
                    }
                    Spacer()
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
