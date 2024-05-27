//
//  FruitList.swift
//  FruitXpert2
//
//  Created by Fauzan Imansyah on 27/05/24.
//

import SwiftUI

struct FruitList: View {
    @State var fruits = [Fruit]()
    @State private var searchText = ""
    @Environment(\.colorScheme) var colorScheme
    @State private var showSettings = false
    
    var searchResults: [Fruit] {
        if searchText.isEmpty {
            return fruits
        } else {
            return fruits.filter { $0.name == searchText}
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(searchResults) { fruit in
                        NavigationLink(destination: FruitInfos(fruit: fruit)) {
                            HStack {
                                Image(fruit.name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50 , height: 50)
                                    .padding()
                                
                                Text(fruit.name)
                                    .font(.system(size: 20, weight: .medium))
                                
                                Spacer()
                                
                                if FavoriteFruit.favorites[fruit.id] != true {
                                    Image(systemName: "star")
                                        .foregroundColor(colorScheme == .dark ? .white : .purple)
                                } else {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(colorScheme == .dark ? .white : .purple)
                                }
                            }
                        }
                    }
                    
                }
                .searchable(text: $searchText)
                .navigationTitle("Fruit list")
                .scrollContentBackground(.hidden)
            }
            .onAppear {
              
                
                // Define the JSON data as a string
                let jsonData = """
                        [
                            {
                                "name": "Apple",
                                "id": 6,
                                "family": "Rosaceae",
                                "order": "Rosales",
                                "genus": "Malus",
                                "nutritions": {
                                  "calories": 52,
                                  "fat": 0.4,
                                  "sugar": 10.3,
                                  "carbohydrates": 11.4,
                                  "protein": 0.3
                                }
                              },
                            {
                                "name": "Banana",
                                "id": 1,
                                "family": "Musaceae",
                                "order": "Zingiberales",
                                "genus": "Musa",
                                "nutritions": {
                                  "calories": 96,
                                  "fat": 0.2,
                                  "sugar": 17.2,
                                  "carbohydrates": 22,
                                  "protein": 1
                                }
                              },
                            {
                                "name": "Avocado",
                                "id": 84,
                                "family": "Lauraceae",
                                "order": "Laurales",
                                "genus": "Persea",
                                "nutritions": {
                                  "calories": 160,
                                  "fat": 14.66,
                                  "sugar": 0.66,
                                  "carbohydrates": 8.53,
                                  "protein": 2
                                }
                              },
                            {
                                "name": "Cherry",
                                "id": 9,
                                "family": "Rosaceae",
                                "order": "Rosales",
                                "genus": "Prunus",
                                "nutritions": {
                                  "calories": 50,
                                  "fat": 0.3,
                                  "sugar": 8,
                                  "carbohydrates": 12,
                                  "protein": 1
                                }
                              },
                            {
                                "name": "Kiwi",
                                "id": 85,
                                "family": "Actinidiaceae",
                                "order": "Ericales",
                                "genus": "Actinidia",
                                "nutritions": {
                                  "calories": 61,
                                  "fat": 0.5,
                                  "sugar": 8.9,
                                  "carbohydrates": 14.6,
                                  "protein": 1.14
                                }
                              },
                            {
                                "name": "Mango",
                                "id": 27,
                                "family": "Anacardiaceae",
                                "order": "Sapindales",
                                "genus": "Mangifera",
                                "nutritions": {
                                  "calories": 60,
                                  "fat": 0.38,
                                  "sugar": 13.7,
                                  "carbohydrates": 15,
                                  "protein": 0.82
                                }
                              },
                            {
                                "name": "Orange",
                                "id": 2,
                                "family": "Rutaceae",
                                "order": "Sapindales",
                                "genus": "Citrus",
                                "nutritions": {
                                  "calories": 43,
                                  "fat": 0.2,
                                  "sugar": 8.2,
                                  "carbohydrates": 8.3,
                                  "protein": 1
                                }
                              },
                            {
                                "name": "Pineapple",
                                "id": 10,
                                "family": "Bromeliaceae",
                                "order": "Poales",
                                "genus": "Ananas",
                                "nutritions": {
                                  "calories": 50,
                                  "fat": 0.12,
                                  "sugar": 9.85,
                                  "carbohydrates": 13.12,
                                  "protein": 0.54
                                }
                              },
                             {
                                "name": "Strawberry",
                                "id": 3,
                                "family": "Rosaceae",
                                "order": "Rosales",
                                "genus": "Fragaria",
                                "nutritions": {
                                  "calories": 29,
                                  "fat": 0.4,
                                  "sugar": 5.4,
                                  "carbohydrates": 5.5,
                                  "protein": 0.8
                                }
                              },
                            {
                                "name": "Watermelon",
                                "id": 25,
                                "family": "Cucurbitaceae",
                                "order": "Cucurbitales",
                                "genus": "Citrullus",
                                "nutritions": {
                                  "calories": 30,
                                  "fat": 0.2,
                                  "sugar": 6,
                                  "carbohydrates": 8,
                                  "protein": 0.6
                                }
                              },
                        ]
                        """
                
                // Convert the JSON string to Data
                guard let data = jsonData.data(using: .utf8) else {
                    fatalError("Invalid JSON data")
                }
                
                // Decode the JSON data into an array of Fruit objects
                do {
                    let fruits = try JSONDecoder().decode([Fruit].self, from: data)
                    self.fruits = fruits
                    for fruit in self.fruits {
                        FavoriteFruit.favorites[fruit.id] = UserDefaults.standard.bool(forKey: "\(fruit.id)")
                    }
                } catch {
                    print("Failed to decode JSON: \(error.localizedDescription)")
                }
            }
        }
    }
}
