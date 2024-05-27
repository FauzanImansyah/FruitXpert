//
//  FruitModel.swift
//  FruitXpert2
//
//  Created by Fauzan Imansyah on 27/05/24.
//

import Foundation

class FavoriteFruit {
    static var favorites = [Int: Bool]()
}

struct Fruit: Codable, Identifiable {
    var id: Int
    var name: String
    var family: String
    var order: String
    var nutritions: Nutritions
}

struct Nutritions: Codable {
    var carbohydrates: Double
    var protein: Double
    var fat: Double
    var calories: Double
    var sugar: Double
}
