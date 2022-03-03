//
//  chapterOne.swift
//  CombineExample
//
//  Created by Jun on 2022/03/03.
//

import SwiftUI
import Combine

struct chapterOne: View {
    @StateObject private var mealGenerator = MealGeneration()
    
    var body: some View {
        VStack {
            Button("Get Random Meal") {
                
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(16)
        }
        
    }
}

struct chapterOne_Previews: PreviewProvider {
    static var previews: some View {
        chapterOne()
    }
}

struct MealData:Decodable {
    let meals:[Meal]
}

struct Meal: Decodable {
    let name:String
    let imageUrlString:String
    let ingredients: [Ingredient]
    let instructions: String
}

extension Meal {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let mealDictionary = try container.decode([String: String?].self)
        
        var index = 1
        var ingredients:[Ingredient] = []
        
        while let ingredient = mealDictionary["strIngredient\(index)"] as? String,
              let measure = mealDictionary["strMeasure\(index)"] as? String,
              !ingredient.isEmpty,
              !measure.isEmpty {
            ingredients.append(.init(name: ingredient, measure: measure))
            index += 1
        }
        
        self.ingredients = ingredients
        self.name = mealDictionary["strMeal"] as? String ?? ""
        self.imageUrlString = mealDictionary["strMealThumb"] as? String ?? ""
        self.instructions = mealDictionary["strInstructions"] as? String ?? ""
    }
}

struct Ingredient: Decodable {
    let name:String
    let measure:String
}

final class MealGeneration: ObservableObject {
    
    @Published var currentMeal: Meal?
    private var cancellable:AnyCancellable?
    
    func fetchRandomMeal() {
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")!)
            .receive(on: DispatchQueue.main)
            .sink { _ in
        } receiveValue: { data, _ in
            if let mealData = try? JSONDecoder().decode(MealData.self, from: data) {
                self.currentMeal = mealData.meals.first
            }
        }

    }
    
}
