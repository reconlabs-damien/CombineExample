//
//  Chapter13.swift
//  CombineExample
//
//  Created by Jun on 2022/04/04.
//

import SwiftUI

enum Tab {
    case first
    case second
}

struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct Chapter13: View {
    
    @State private var selectedTab: Tab = .first
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .first:
                NavigationView {
                    FirstView13()
                }
            case .second:
                NavigationView {
                    SecondView13()
                }
            }
            
            CustomTapView(selectedTab: $selectedTab)
                .frame(height: 50)
        }
    }
}

struct CustomTapView: View {
    @Binding var selectedTab: Tab
    var body: some View {
        HStack {
            Spacer()
            Button {
                selectedTab = .first
            } label: {
                VStack {
                    Image(systemName: "house")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Text("First")
                        .foregroundColor(.primary)
                        .font(.caption2)
                }
                .foregroundColor(selectedTab == .first ? .blue : .primary)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .shadow(radius: 2)
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.primary)
                        .frame(width: 72, height: 72)
                }
                .offset(y: -32)
            }
            .buttonStyle(TabButtonStyle())
            
            Spacer()
            
            Button {
                selectedTab = .second
            } label: {
                VStack {
                    Image(systemName: "chart.bar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Text("Second")
                        .foregroundColor(.primary)
                        .font(.caption2)
                }
                .foregroundColor(selectedTab == .second ? .blue : .primary)
            }
            Spacer()
        }
    }
}

struct FirstView13: View {
    var body: some View {
        Color(.systemGray6)
            .ignoresSafeArea()
            .navigationTitle("First")
    }
}

struct SecondView13: View {
    var body: some View {
        Color(.systemGray4)
            .ignoresSafeArea()
            .navigationTitle("Second")
    }
}

struct Chapter13_Previews: PreviewProvider {
    static var previews: some View {
        Chapter13()
    }
}
