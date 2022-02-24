//
//  ListExample.swift
//  CombineExample
//
//  Created by Jun on 2022/02/24.
//

import SwiftUI

struct Animal: Identifiable {
    let id = UUID()
    let image: String
    let name: String
}

struct AnimalCell: View {
    
    private var animal:Animal
    
    init(animal: Animal) {
        self.animal = animal
    }
    
    var body: some View {
        HStack {
            Text(self.animal.image)
            Text(self.animal.name)
        }
    }
    
}

struct ListExample: View {
    
    let animals = [
        Animal(image: "🐈", name: "Cat"),
        Animal(image: "🐅", name: "Tiger"),
        Animal(image: "🦍", name: "Monkey"),
        Animal(image: "🦧", name: "Gorilla")
    ]
    
    @State var text:String = ""
    
    var body: some View {
        VStack {
            CustomSearchBar(text: $text)
            List(self.animals.filter {
                self.text.isEmpty ? true : $0.name.contains(self.text)
            }) {
                Text($0.name)
            }
        }
    }
}

struct ListExample_Previews: PreviewProvider {
    static var previews: some View {
        ListExample()
    }
}
