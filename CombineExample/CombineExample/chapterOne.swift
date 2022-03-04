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
    
    var actionButton: some View {
        Button("Get Random Meal") {
            mealGenerator.fetchRandomMeal()
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .cornerRadius(16)
        .onAppear {
            mealGenerator.fetchRandomMeal()
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                actionButton
                if let name = mealGenerator.currentMeal?.name {
                    Text(name)
                        .font(.largeTitle)
                }
                AsyncImageView(urlString: $mealGenerator.currentImageURLString)
                
                if let ingredients = mealGenerator.currentMeal?.ingredients {
                    HStack {
                        Text("Ingredients")
                            .font(.title2)
                        Spacer()
                    }
                    
                    ForEach(ingredients, id:\.self) { ingredient in
                        HStack {
                            Text(ingredient.name + " - " + ingredient.measure)
                            Spacer()
                            
                        }
                    }
                }
                
                if let instructions = mealGenerator.currentMeal?.instructions {
                    
                    HStack {
                        Text("Instructions")
                            .font(.title2)
                        Spacer()
                    }
                    
                    Text(instructions)
                }
                
            }.padding()
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

struct Ingredient: Decodable, Hashable {
    let name:String
    let measure:String
}

final class MealGeneration: ObservableObject {
    
    @Published var currentMeal: Meal?
    @Published var currentImageURLString:String?
    private var cancellable:AnyCancellable?
    
    func fetchRandomMeal() {
        cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")!)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { data, _ in
                if let mealData = try? JSONDecoder().decode(MealData.self, from: data) {
                    self.currentMeal = mealData.meals.first
                    self.currentImageURLString = mealData.meals.first?.imageUrlString
                }
            }
        
    }
    
}

struct AsyncImageView: View {
    
    @StateObject private var imageLoader = ImageLoader()
    @Binding var urlString:String?
    
    init(urlString: Binding<String?>) {
        self._urlString = urlString
    }
    
    var image: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
            } else {
                Text("No image")
            }
        }
    }
    
    var body: some View {
        
        image.onChange(of: urlString) { newValue in
            if let urlString = urlString,
               let url = URL(string: urlString) {
                imageLoader.url = url
                imageLoader.load()
            }
        }
        
        
    }
    
    
}

final class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    var url: URL?
    
    func load() {
        guard let url = url else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$image)
    }
    
    
}
