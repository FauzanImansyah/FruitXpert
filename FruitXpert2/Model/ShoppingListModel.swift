//
//  ShoppingListModel.swift
//  FruitXpert2
//
//  Created by Fauzan Imansyah on 27/05/24.
//

import Foundation
import SwiftUI
import Combine

struct ShoppingList : Identifiable, Codable {
    var id = String()
    var shoppingItem = String()
}

class ShoppingListStorage: ObservableObject {
    @Published var shoppinglists = [ShoppingList]()
}
