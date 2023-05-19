//
//  MyCartViewModel.swift
//  EasyMeal
//
//  Created by Pink Flamingo on 5/19/23.
//

import SwiftUI

class MyCartViewModel: ObservableObject {
    var openRecipes: () -> Void
    @Published var items: [ShoppingItem] = []
    
    func loadItems() {
        let storedItems = UserDefaults.standard.array(forKey: "savedItems") as? [[String: Any]] ?? []
        print("stored items", storedItems)
        items = storedItems.map { ShoppingItem(from: $0) }
        print("items", items)
    }
    
    func saveItems() {
        let encodedItems = items.map { $0.toDictionary() }
        UserDefaults.standard.set(encodedItems, forKey: "savedItems")
    }
    
    func checkItems() {
        var i = 0
        while(i < items.count) {
            if(items[i].isChecked == false){
                self.items[i].isChecked.toggle()
                print(i)
            }
            i+=1
        }
        self.saveItems()
    }
    
    func deleteChecked() {
        self.items.removeAll(where: { $0.isChecked })
        self.saveItems()
    }
    
    init(newOpenRecipes: @escaping () -> Void) {
        openRecipes = newOpenRecipes
        loadItems()
    }
}
