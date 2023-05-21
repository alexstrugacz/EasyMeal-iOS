//
//  SignIn.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 2/10/23.
//


//NavigationLink(
//    destination: MainView(initialTab: .cooktop) { EmptyView() },
//    isActive: $showSignUpView
//) {
//    EmptyView()
//}
//.hidden()

import SwiftUI
import Firebase



struct SignIn: View {
    @ObservedObject var signInViewModel: SignInViewModel = SignInViewModel()
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        if firebaseManager.isLoggedIn {
            MainView(initialTab: .mic, content: {})
        } else if signInViewModel.loginTab == .signUp {
            SignUp()
        } else if signInViewModel.loginTab == .signIn {
            SignInView(userIsLoggedIn: $signInViewModel.userIsLoggedIn, showSignUpView: $signInViewModel.showSignUpView)
        } else if signInViewModel.loginTab == .preview {
            ContentView(triggerNextPage: signInViewModel.triggerNextPage)
        }
        
    }
}
    
