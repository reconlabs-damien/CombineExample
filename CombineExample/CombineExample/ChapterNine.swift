//
//  ChapterNine.swift
//  CombineExample
//
//  Created by Jun on 2022/03/22.
//

import SwiftUI

struct ChapterNine: View {
    
    let categories = ["Fruits", "Fish", "Dairy"]
    @Namespace private var animation
    @State private var selectedCategory = "Fruits"
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(categories, id:\.self) { category in
                        
                        Button {
                            withAnimation {
                                selectedCategory = category
                            }
                            
                        } label: {
                            VStack {
                                Text(category)
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                                    .matchedGeometryEffect(id: category, in: animation, isSource: true)
                            }
                        }.accentColor(.primary)
                    }.overlay(RoundedRectangle(cornerRadius: 5)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: selectedCategory, in: animation, isSource: false))
                }
            }
            Spacer()
        }
        .navigationTitle("Groceries")
        .padding()
    }
}

struct ChapterNine_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChapterNine()
        }
        
    }
}
