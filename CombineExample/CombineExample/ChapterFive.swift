//
//  ChapterFive.swift
//  CombineExample
//
//  Created by Jun on 2022/03/17.
//

import SwiftUI

struct ChapterFive: View {
    
    @StateObject private var keyboardHandler = KeyboardHandler()
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        VStack(spacing: 15) {
            Spacer()
            Text("Increment")
                .font(.system(size: 64, weight: .semibold))
                .foregroundColor(.white)
            
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                
                TextField("Email", text: $email)
            }.padding(.all, 20)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                
                SecureField("Password", text: $password)
            }.padding(.all, 20)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            Button(action: {}) {
                Text("Login")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .medium))
            }.frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.red.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            
            Spacer()
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .padding(.bottom, keyboardHandler.keyboardHeight)
        .animation(.default)
        .background(
            Image("fitness")
                .resizable()
                .aspectRatio(contentMode: .fill)
        ).edgesIgnoringSafeArea(.all)
    }
}

struct ChapterFive_Previews: PreviewProvider {
    static var previews: some View {
        
        
        ChapterFive()
    }
}

