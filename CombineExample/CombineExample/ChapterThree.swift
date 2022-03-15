//
//  ChapterThree.swift
//  CombineExample
//
//  Created by Jun on 2022/03/15.
//

import SwiftUI

struct ChapterThree: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack {
            Picker("Mode", selection: $isDarkMode) {
                Text("Light")
                    .tag(false)
                Text("Dark")
                    .tag(true)
            }.pickerStyle(SegmentedPickerStyle())
                .padding()
            
            Spacer()
            
            List(0..<5, id: \.self) { num in
                NavigationLink(destination: Text("\(num)")) {
                    Text("\(num)")
                }
            }
        }.navigationTitle("Mode Switch")
    }
}

struct ChapterThree_Previews: PreviewProvider {
    static var previews: some View {
        ChapterThree()
    }
}
