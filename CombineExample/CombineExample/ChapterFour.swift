//
//  ChapterFour.swift
//  CombineExample
//
//  Created by Jun on 2022/03/16.
//

import SwiftUI

struct ChapterFour: View {
    
    @State private var isExpanded = false
    @State private var selectedNum = 1
    
    @State private var isScrollExpanded = false
    @State private var scrollSelectedNum = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Dropdown")
                .font(.largeTitle)
            Text("Number of items")
                .font(.title3)
            
            DisclosureGroup("\(selectedNum)", isExpanded: $isExpanded) {
                VStack {
                    ForEach(1...5, id: \.self) { num in
                        Text("\(num)")
                            .font(.title3)
                            .padding(.all)
                            .onTapGesture {
                                self.selectedNum = num
                                withAnimation {
                                    self.isExpanded.toggle()
                                }
                            }
                    }
                }
            }
            .accentColor(.white)
            .font(.title2)
            .foregroundColor(.white)
            .padding(.all)
            .background(.blue)
            .cornerRadius(8)
            
            Text("Number of items")
                .font(.title3)
            
            DisclosureGroup("\(scrollSelectedNum)", isExpanded: $isScrollExpanded) {
                ScrollView {
                    VStack {
                        ForEach(1...500, id: \.self) { num in
                            Text("\(num)")
                                .frame(maxWidth: .infinity)
                                .font(.title3)
                                .padding(.all)
                                .onTapGesture {
                                    self.scrollSelectedNum = num
                                    withAnimation {
                                        self.isScrollExpanded.toggle()
                                    }
                                }
                        }
                    }
                }.frame(height: 150)
            }
            .accentColor(.white)
            .font(.title2)
            .foregroundColor(.white)
            .padding(.all)
            .background(.blue)
            .cornerRadius(8)
            
            Spacer()
        }.padding(.all)
    }
}

struct ChapterFour_Previews: PreviewProvider {
    static var previews: some View {
        ChapterFour()
    }
}
