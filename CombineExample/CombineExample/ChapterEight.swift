//
//  ChapterEight.swift
//  CombineExample
//
//  Created by Jun on 2022/03/21.
//

import SwiftUI

struct ChapterEight: View {
    //let items:[Item]
    
    @State private var addIsPresented = false
    @State private var settingIsPresented = false
    
    var proteinItemsList:some View {
        ScrollView {
            VStack(alignment: .leading) {
//                ForEach(items, id:\.name) { item in
//                    VStack {
//                        ItemViewRow(item: item)
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(8)
//                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
            }
        }
    }
}

struct ChapterEight_Previews: PreviewProvider {
    static var previews: some View {
        ChapterEight()
    }
}

struct AddProteinView: View {
    @State private var name = ""
    @State private var amount = ""
    @Binding var isPresented: Bool
    
    
    var body: some View {
        List {
            Section {
                HStack {
                    TextField("Name", text: $name)
                    Spacer()
                }
                
                HStack {
                    TextField("Amount(g)", text: $amount)
                    Spacer()
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Add Protein")
        .navigationBarItems(trailing: Button("Done", action: {
            isPresented = false
        }))
    }
    
}

struct SettingsView: View {
    
    var body: some View {
        Text("heel")
    }
    
    
}
