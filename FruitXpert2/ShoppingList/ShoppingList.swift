//
//  ShoppingList.swift
//  FruitXpert2
//
//  Created by Fauzan Imansyah on 27/05/24.
//

import SwiftUI

struct ShoppingListView: View {
    @ObservedObject var shoppingListStorage = ShoppingListStorage()
    @State private var newIngredient: String = ""
    @State private var addedIngredients = 0
    @State private var didLoad = true
    
    @Environment(\.colorScheme) var colorScheme

    // MARK: - searchBar
    var searchBar: some View {
        HStack {
            TextField("Add an ingredient", text: self.$newIngredient)
                .padding(.leading, 20)
                .frame(height: 40)
                .background(colorScheme == .dark ? Color(UIColor.white).opacity(0.2) : Color(UIColor.lightGray).opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 100))
            Button(action: addIngredient, label: {
                Image(systemName: "plus")
                    .font(.system(size: 20))
                    .foregroundColor(.purple)
            })
        }
    }
    
    // MARK: - addIngredient
    func addIngredient() {
        shoppingListStorage.shoppinglists.append(ShoppingList(id: String(shoppingListStorage.shoppinglists.count + 1), shoppingItem: newIngredient))
        addedIngredients += 1
        UserDefaults.standard.set(addedIngredients, forKey: "NumberIngredients")
        UserDefaults.standard.set(newIngredient, forKey: "\(addedIngredients-1)Added")
        self.newIngredient = ""
    }
    
    // MARK: - deleteItem
    func deleteItem(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]
        for i in index..<addedIngredients-1 {
            let nextUD = UserDefaults.standard.string(forKey: "\(i+1)Added")!
            UserDefaults.standard.set(nextUD, forKey: "\(i)Added")
        }
        UserDefaults.standard.removeObject(forKey: "\(addedIngredients-1)Added")
        shoppingListStorage.shoppinglists.remove(atOffsets: offsets)
        addedIngredients -= 1
        UserDefaults.standard.set(addedIngredients, forKey: "NumberIngredients")
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                searchBar.padding()
                List {
                    ForEach(self.shoppingListStorage.shoppinglists) { shoppinglist in
                        Text(shoppinglist.shoppingItem)
                    }.onDelete(perform: self.deleteItem)
                }
                .navigationTitle("ShoppingList")
            }
        }
        .onAppear(perform: {
            if didLoad {
                addedIngredients = UserDefaults.standard.integer(forKey: "NumberIngredients")
                for i in 0..<addedIngredients {
                    shoppingListStorage.shoppinglists.append(ShoppingList(id: String(shoppingListStorage.shoppinglists.count + 1), shoppingItem: UserDefaults.standard.string(forKey: "\(i)Added")!))
                }
                didLoad = false
            }
        })
        .navigationViewStyle(.stack)
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}

