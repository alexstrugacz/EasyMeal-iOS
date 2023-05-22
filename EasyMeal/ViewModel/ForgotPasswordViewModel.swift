//
//  ForgotPasswordViewModel.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 5/22/23.
//

import SwiftUI
import FirebaseAuth

class ForgotPasswordViewModel : ObservableObject {
    @Published var passwordResetSent = false
    @Published var email = ""
    var closeTab: () -> Void
    
    init(closeTab: @escaping () -> Void) {
        self.closeTab = closeTab
    }
    
    func sendPasswordReset() {
        
    }
}
