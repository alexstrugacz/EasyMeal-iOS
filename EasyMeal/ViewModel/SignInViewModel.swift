//
//  SignInViewModel.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/21/23.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    @Published var showView = false
    @Published var showView2 = false
    @Published var userIsLoggedIn = false
    @Published var showSignUpView = false
    @Published var loginTab: LoginTabs = .preview
    
    func triggerNextPage() {
        print("TRIGGERED")
        loginTab = .signIn
    }

}
