//
//  FruitInfo.swift
//  FruitXpert2
//
//  Created by Fauzan Imansyah on 27/05/24.
//

import SwiftUI

struct FruitInfos: View {
    @State var fruit: Fruit
    @State var isFavorite: Bool = false
    @Environment(\.colorScheme) var colorScheme

    
    var body: some View {
        ZStack {
            
            // Top view
            VStack {
                    Text(fruit.name)
                    .font(.system(size: 30, weight: .bold, design: .none))
                    .foregroundColor(.black)
                        
                    Spacer()
                        .frame(height: 20)
                    
                    Image(fruit.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(30)
                        .padding()
                                    
                    Spacer()
                        .frame(height: 10)
                
                // Favorite button part of the view
                    VStack {
                        if isFavorite == false {
                            Button() {
                                FavoriteFruit.favorites[fruit.id] = true
                                isFavorite = true
                                UserDefaults.standard.set(FavoriteFruit.favorites[fruit.id], forKey: "\(fruit.id)")
                            } label: {
                                Label("Favorit", systemImage: "star")
                                    .frame(height: 20)
                                    .foregroundColor(colorScheme == .dark ? .white : .purple)
                                    .padding()
                                    .background(colorScheme == .dark ? .purple : .white)
                                    .clipShape(RoundedRectangle(cornerRadius: 100))
                            }
                        } else {
                            Button() {
                                FavoriteFruit.favorites[fruit.id] = false
                                isFavorite = false
                                UserDefaults.standard.set(FavoriteFruit.favorites[fruit.id], forKey: "\(fruit.id)")
                            } label: {
                                Label("Favorit", systemImage: "star.fill")
                                    .frame(height: 20)
                                    .foregroundColor(colorScheme == .dark ? .white : .purple)
                                    .padding()
                                    .background(colorScheme == .dark ? .purple : .white)
                                    .clipShape(RoundedRectangle(cornerRadius: 100))
                            }
                        }
                        
                        Spacer()
                            .frame(height: 30)
                        
                        // Nutritions' list
                        List {
                            Section("Description :") {
                                HStack {
                                    Text("Carbohydrates: ")
                                    Spacer()
                                    Text("\(fruit.nutritions.carbohydrates, specifier: "%.2f")")
                                        .foregroundColor(.purple)
                                }
                                
                                HStack {
                                    Text("Protein: ")
                                    Spacer()
                                    Text("\(fruit.nutritions.protein, specifier: "%.2f")")
                                        .foregroundColor(.purple)
                                }
                                
                                HStack {
                                    Text("Fat: ")
                                    Spacer()
                                    Text("\(fruit.nutritions.fat, specifier: "%.2f")")
                                        .foregroundColor(.purple)
                                }
                                
                                HStack {
                                    Text("Calories: ")
                                    Spacer()
                                    Text("\(fruit.nutritions.calories, specifier: "%.2f")")
                                        .foregroundColor(.purple)
                                }
                                
                                HStack {
                                    Text("Sugar: ")
                                    Spacer()
                                    Text("\(fruit.nutritions.sugar, specifier: "%.2f")")
                                        .foregroundColor(.purple)
                                }

                            }
                        }
                        .font(.system(size: 15, weight: .bold))
                        .scrollContentBackground(.hidden)
                        .onAppear {
                            if FavoriteFruit.favorites[fruit.id] != true {
                                isFavorite = false
                            } else {
                                isFavorite = true
                            }
                    }
                }
            }
        }
    }
}


struct FruitInfos_Previews: PreviewProvider {
    static var previews: some View {
        FruitInfos(fruit: Fruit(id: 6, name: "Apple", family: "Rosaceae", order: "Rosales", nutritions: Nutritions(carbohydrates: 11.4, protein: 0.3, fat: 0.4, calories: 52, sugar: 10.3)))
    }
}

