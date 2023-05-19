//
//  PantryIngredient.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/17/23.
//

import Foundation
struct PantryIngredient: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var isChecked: Bool
    var category: String
    
    init(name: String, isChecked: Bool, category: String) {
        self.name = name
        self.isChecked = isChecked
        self.category = category
    }
    
    init(from dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.isChecked = dictionary["isChecked"] as? Bool ?? false
        self.category = dictionary["category"] as? String ?? ""
    }
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "isChecked": isChecked,
            "category": category
        ]
    }
}
