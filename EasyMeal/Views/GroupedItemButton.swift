//
//  GroupedItemButton.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/17/23.
//

import SwiftUI

struct GroupedItemButton: View {
    @ObservedObject var groupButtonViewModel: GroupButtonViewModel = GroupButtonViewModel()
    @Binding var selectedItems: [String]
    @State var checked = false
    var item: PantryIngredient
    var toggleItem: (String) -> Void
    
    init(
        newSelectedItems: Binding<[String]>,
        newItem: PantryIngredient,
        newToggleItem: @escaping (String) -> Void
    ) {
        _selectedItems = newSelectedItems
        item = newItem
        toggleItem = newToggleItem

        
        for string in newSelectedItems {
            if (string.wrappedValue==newItem.name) {
                groupButtonViewModel.setTrue()
            }
        }
    }
    
    var body: some View {
        Button(action: {
            groupButtonViewModel.toggle()
            toggleItem(item.name)
        }) {
            Text(item.name)
                .foregroundColor(groupButtonViewModel.checked ? .white: .black)
                .padding(.horizontal, 15)
                .frame(height: 34)
                .background(groupButtonViewModel.checked ? custGreen : Color(hex: "#E9E9E9"))
                .cornerRadius(17)
                .minimumScaleFactor(0.5) // Set a minimum scale factor to allow the text to scale down
                .fixedSize(horizontal: true, vertical: false)
                .font(.system(size: 15)) // Set the initial font size
        }
        .buttonStyle(PlainButtonStyle())
    }
}
