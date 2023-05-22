//
//  Ext+String.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/18/23.
//

import Foundation
extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
