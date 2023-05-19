//
//  PantryViewModel.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/17/23.
//

import SwiftUI

class PantryViewModel: ObservableObject {
    @Published var loading = false
    @Published var selectedItems: [String] = []
    @Published var items: [PantryIngredient] = []
    @Published var groupedItems: [GroupedItems] = []
   
    func resetData() {
        UserDefaults.standard.set([], forKey: "pantryItems")
        selectedItems = []
        loadData()
        
    }
    
    func loadData() {
        loading = true
        loadItems()
        let API_URL = "https://easymeal-backend.herokuapp.com/ingredients?query=%27%27"
        guard let url = URL(string: API_URL) else {
            loading = false
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.loading = false
                return
            }
            
            
            do {
                guard let dataSecure = data else {
                    self.loading = false
                    return
                }
                let json = try JSONSerialization.jsonObject(with: dataSecure, options: .allowFragments) as? [String: [[String: Any]]]
                    
                
                guard let ingredients = json?["ingredients"] else {
                    self.loading = false
                    return
                }
                self.resetItems()
                for ingredient in ingredients {
                    guard let name = ingredient["ingredient"] as? String, let category = ingredient["category"] as? String else {
                        continue
                    }
                    
                    var itemChecked = false
                    
                    if self.selectedItems.firstIndex(where: { $0 == name }) != nil {
                        itemChecked = true
                    }
                    
                    self.addItem(item: PantryIngredient(
                        name: name, isChecked: itemChecked, category: category
                    ))
                }
                
                
                let encodedItems = self.items.map { $0.toDictionary() }
                let groupedData: [String: [PantryIngredient]] = Dictionary(grouping: self.items, by: { $0.category })
                
                
                for key in groupedData.keys.sorted() {
                    guard let currentGroupedItems: [PantryIngredient] = groupedData[key] else {
                        self.loading = false
                        return
                    }
                    let groupItem: GroupedItems = GroupedItems(name: key, pantryIngredients: currentGroupedItems.sorted(by: { a, b in
                        return a.name<b.name
                    }))
                    self.addGroupedItem(item: groupItem)
                }
                DispatchQueue.main.async {
                    self.loading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.loading = false
                }
            }
        }
        task.resume()
    }
    
    init() {
        loadData()
    }
    
    func addGroupedItem(item: GroupedItems) {
        groupedItems.append(item)
    }
    func addItem(item: PantryIngredient) {
        items.append(item)
    }
    func toggleItem(index: Int) {
        DispatchQueue.main.async {
            self.items[index].isChecked = !self.items[index].isChecked
        }
    }
    func selectItem(item: String) {
        if selectedItems.contains(item) == false {
            selectedItems.append(item)
        }
        saveItems()
    }
    func removeItem(item: String) {
        guard let selectedItemIndex = selectedItems.firstIndex(of: item) else { return }
        selectedItems.remove(at: selectedItemIndex)
        saveItems()
    }
    func toggleItem(item: String) {
        if selectedItems.contains(item) == false {
            selectItem(item: item)
        } else {
            removeItem(item: item)
        }

    }
    func saveItems () {
        UserDefaults.standard.set(selectedItems, forKey: "pantryItems")
    }
    func loadItems() {
        selectedItems = UserDefaults.standard.array(forKey: "pantryItems") as? [String] ?? []
    }
    
    func resetItems() {
        items = []
        groupedItems = []
    }
}
