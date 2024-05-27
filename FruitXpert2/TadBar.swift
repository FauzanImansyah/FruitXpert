//
//  TadBar.swift
//  FruitXpert2
//
//  Created by Fauzan Imansyah on 27/05/24.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedIndex = 0
    @Environment(\.colorScheme) var colorScheme
    
    let icons = [
    "camera",
    "basket",
    "cart.badge.plus",
    ]
    
    let names = [
    "Fruit Recognition",
    "Fruit List",
    "Shopping List"
    ]

    var body: some View {
        VStack {
            ZStack {
                switch selectedIndex {
                case 0:
                    FruitMLView(classifier: ImageClassifier())

                case 1:
                    FruitList()

                case 2:
                    ShoppingListView()

                default:
                    FruitMLView(classifier: ImageClassifier())

                }
            }
            
            
            HStack {
                ForEach(0..<3, id: \.self) { number in
                    Button(action: {
                        self.selectedIndex = number
                    }, label: {
                        Spacer()
                        VStack {
                            Image(systemName: icons[number])
                                .font(.system(size: 35,
                                              weight: .regular,
                                              design: .default))
                                .foregroundColor(selectedIndex == number ? .blue : Color(UIColor.lightGray))
                            
                            Text(names[number])
                                .font(.system(size: 20,
                                              weight: .regular,
                                              design: .default))
                                .foregroundColor(selectedIndex == number ? .blue : Color(UIColor.lightGray))
                        }
                        Spacer()
                    })
                }
            }
            .animation(.easeOut(duration: 0.8), value: selectedIndex)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
