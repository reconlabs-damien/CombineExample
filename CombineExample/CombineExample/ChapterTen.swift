//
//  ChapterTen.swift
//  CombineExample
//
//  Created by Jun on 2022/03/23.
//

import SwiftUI

struct MasterView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 35) {
                ChapterTen()
                CardListView()
                Spacer()
            }.padding(25)
        }
    }
}

struct ChapterTen: View {
    var body: some View {
        HStack {
            VStack {
                Text("Good Morning")
                    .font(.callout)
                    .foregroundColor(Color(.systemGray3))
                Text("Pat Flores")
            }
            Spacer()
            
            Image("me")
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(10)
        }
    }
}

struct ChapterTen_Previews: PreviewProvider {
    static var previews: some View {
        MasterView()
            .environmentObject(Wallet())
    }
}


struct Card {
    let income:Int
    let expenses:Int
    var balance: Int {
        income - expenses
    }
    let cardNumber:String
    let imageName: String
    
    var isSelected = false
    var backgroundColor: Color {
        isSelected ? Color.primaryPurple : Color.primaryYellow
    }
    
    var textColor: Color {
        isSelected ? .white : .black
    }
}

let cardsData:[Card] = [
    .init(income: 2548, expenses: 748, cardNumber: "**** 2561", imageName: "visa", isSelected: true),
    .init(income: 1234, expenses: 344, cardNumber: "**** 4355", imageName: "mastercard"),
    .init(income: 4433, expenses: 122, cardNumber: "**** 3455", imageName: "american-express")
]

final class Wallet: ObservableObject {
    @Published var cards = cardsData
    
    var selectedCard: Card {
        cards.first(where: { $0.isSelected })!
    }
}

struct CardListView: View {
    @EnvironmentObject var wallet: Wallet
    
    var headerView: some View {
        HStack {
            Text("Your cards")
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            Button("Add new") {}
            .font(.callout)
            .foregroundColor(Color.primaryPurple)
            .padding(.trailing)
        }
    }
    
    var body: some View {
        VStack {
            headerView
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(wallet.cards.indices, id: \.self) { index in
                        CardView(card: wallet.cards[index])
                            .onTapGesture {
                                wallet.cards.indices.forEach { index in
                                    wallet.cards[index].isSelected = false
                                }
                                
                                wallet.cards[index].isSelected.toggle()
                            }
                    }
                }
            }
        }
    }
}

struct CardView: View {
    let card: Card
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(card.imageName)
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .padding(.horizontal, 10)
            .padding(.top, 5)
            
            Spacer()
            
            Text("$\(card.balance)")
                .foregroundColor(Color.textColor)
                .fontWeight(.bold)
            
            Text("\(card.cardNumber)")
                .foregroundColor(Color.textColor)
                .font(.callout)
        }
        .padding(.vertical, 10)
        .background(card.backgroundColor)
        .cornerRadius(10)
        .frame(width: 100, height: 150)
    }
}
