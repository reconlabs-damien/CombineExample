//
//  BalanceView.swift
//  CombineExample
//
//  Created by Jun on 2022/03/24.
//

import SwiftUI

struct BalanceView: View {
    @EnvironmentObject var wallet:Wallet
    @State private var incomePercentage = 0
    
    var headerView: some View {
        HStack {
            Text("Balance")
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            Text("$\(wallet.selectedCard.balance)")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color.primaryPurple)
                .padding(.trailing)
        }
    }
    
    var incomeView: some View {
        HStack(spacing: 10) {
            
            Image(systemName: "arrow.down")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.primaryPurple)
                .padding(10)
                .background(Color.primaryPurple.opacity(0.2))
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text("In")
                    .font(.headline)
                    .foregroundColor(Color(.systemGray3))
                
                Text("$\(wallet.selectedCard.income)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
        }
        
    }
    
    var expensesView: some View {
        HStack(spacing: 10) {
            
            Image(systemName: "arrow.up")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.primaryYellow)
                .padding(10)
                .background(Color.primaryYellow.opacity(0.2))
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text("Out")
                    .font(.headline)
                    .foregroundColor(Color(.systemGray3))
                
                Text("$\(wallet.selectedCard.expenses)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
        }
    }
    
    var body: some View {
        VStack(spacing: 15) {
            headerView
            HorizontalProgressView(percentage: $incomePercentage)
                .padding(.bottom, 15)
            HStack {
                incomeView
                Spacer()
                expensesView
            }
            Spacer()
        }
        .onAppear(perform: {
            update()
        })
        .onChange(of: wallet.selectedCard) { _ in
            update()
        }
    }
    
    private func update() {
        withAnimation(.spring(response: 2)) {
            incomePercentage = wallet.selectedCard.incomePercentage
        }
        
    }
}


struct HorizontalProgressView:View {
    
    @EnvironmentObject var wallet:Wallet
    @Binding var percentage:Int
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.primaryYellow)
                    .frame(height:20)
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.primaryYellow)
                    .frame(width: proxy.size.width * CGFloat(percentage) / 100, height:20)
            }
        }
    }
}
