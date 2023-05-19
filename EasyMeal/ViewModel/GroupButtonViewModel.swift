//
//  GroupButtonViewModel.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/17/23.
//

import SwiftUI

class GroupButtonViewModel : ObservableObject {
    @Published var checked = false
    func setTrue() {
        checked = true
    }
    func setFalse() {
        checked = false
    }
    func toggle() {
        checked = !checked
    }
}
