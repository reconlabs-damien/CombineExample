//
//  Chapter12.swift
//  CombineExample
//
//  Created by Jun on 2022/03/31.
//

import SwiftUI
import SystemConfiguration

struct Chapter12: View {
    
    @State private var searchText = ""
    
    let inProgressCard = Chapter12Cell.init(iconName: "moon", title: "The Silent Night Vibes", subTitle: "2/4 Session left", percentageComplete: 75)
    
    let recommendedCards:[Chapter12Cell] = [
        .init(iconName: "face.smiling", title: "Happiness and Joyful", subTitle: "4 Sessions", percentageComplete: nil),
        .init(iconName: "heart", title: "Lovely and Vibes", subTitle: "5 Sessions", percentageComplete: nil)
    ]
    
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
    
    
    @ViewBuilder
    var inProgressSectionView: some View {
        HStack {
            Text("In Progress")
                .font(.custom("Avenir-Heavy", size: 18))
            Spacer()
        }
        Chapter12SubView(card: inProgressCard)
        
    }
    
    @ViewBuilder
    var recommendedSectionView: some View {
        HStack {
            Text("Recommended")
                .font(.custom("Avenir-Heavy", size: 18))
            Spacer()
            
            Image(systemName: "arrow.right")
                .foregroundColor(Color(.systemBlue))
        }
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(recommendedCards, id:\.self) { card in
                    Chapter12SubView(card: card)
                        .frame(width: 200)
                }
            }
        }
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
                inProgressSectionView
                recommendedSectionView
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

struct Chapter12Cell:Hashable {
    let iconName: String
    let title: String
    let subTitle: String
    let percentageComplete: Double?
    var percentageText: String? {
        guard let percentageComplete = percentageComplete else {
            return nil
        }
        
        return "\(percentageComplete)%"
        
    }
}

struct Chapter12SubView: View {
    
    let card:Chapter12Cell
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 10).fill(Color.white)
            
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Image(systemName: card.iconName)
                        .foregroundColor(Color(.systemBlue))
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBlue).opacity(0.1)))
                    Spacer()
                }
                Text(card.title)
                    .font(.custom("Avenir-Heavy", size: 22))
                Text(card.subTitle)
                    .modifier(Chapter12TextStyle())
                if let percentageText = card.percentageText {
                    HStack {
                        Text(percentageText)
                            .modifier(Chapter12TextStyle())
                        Spacer()
                        ProgressView(value: card.percentageComplete, total: 100)
                            .progressViewStyle(MeditationProgressViewStyle())
                    }
                }
            }
            .padding()
        }
    }
}

struct Chapter12TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.custom("Avenir-Medium", size: 18))
            .foregroundColor(Color(.systemGray))
    }
}

struct MeditationProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGroupedBackground))
                .frame(height: 10)
            
            ProgressView(configuration)
                .accentColor(Color(.systemBlue))
                .scaleEffect(x: 1, y: 2.5)
        }
    }
}
