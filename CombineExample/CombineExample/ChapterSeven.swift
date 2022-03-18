//
//  ChapterSeven.swift
//  CombineExample
//
//  Created by Jun on 2022/03/18.
//

import SwiftUI

struct ChapterSeven: View {
    
    var title: some View {
        Text("Title")
            .titleStyle()
    }
    
    var subtitle: some View {
        Text("SubTitle")
             .font(.title2)
             .fontWeight(.medium)
             .foregroundColor(.black)
    }
    
    var bodyText: some View {
        Text("Here is stack of doom where it is impossible to understand what is happening and very common in SwiftUI")
            .font(.body)
            .fontWeight(.light)
            .foregroundColor(.black)
    }
    
    var actionButtonHolder: some View {
        HStack {
            Spacer()
            Button {
                
            } label: {
                Text("OK")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding(.vertical)
            .frame(width: 100)
            .background(Color.blue)
            .cornerRadius(16)
            Spacer()
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            title
            subtitle
            bodyText
            bodyText
            bodyText
            EmofiGalleryView()
            
            Spacer()
            actionButtonHolder
            
        }.padding()
    }
}

struct ChapterSeven_Previews: PreviewProvider {
    static var previews: some View {
        ChapterSeven()
    }
}


struct EmofiGalleryView: View {
    
    var body: some View {
        let rows: [GridItem] = Array(repeating: .init(.fixed(20)), count: 2)
        
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .top) {
                ForEach( (0...79), id: \.self) {
                    let codepoint = $0 + 0x1f600
                    let codepointString = String(format: "%02X", codepoint)
                    
                    Text("\(codepointString)")
                        .font(.footnote)
                    
                    Text("\(codepoint)")
                        .font(.largeTitle)
                }
            }
        }
    }
    
    
}


struct Title: ViewModifier {
    
    func body(content: Content) -> some View {
        
        let font = Font.largeTitle.weight(.medium)
        
        content
            .font(font)
            .foregroundColor(.gray)
            .padding()
            .border(Color.gray)
    }
    
}


