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
    @State var isActive: Bool = false
    @StateObject var signInViewModel: SignInViewModel = SignInViewModel()
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        ZStack {
            if (isActive) {
                if firebaseManager.isLoggedIn {
                    MainView(initialTab: .mic, content: {})
                        .onAppear {
                            firebaseManager.error = nil
                            firebaseManager.loading = false
                        }
                } else if signInViewModel.loginTab == .signUp {
                    SignUp(loginTab: $signInViewModel.loginTab)
                        .onAppear {
                            firebaseManager.error = nil
                            firebaseManager.loading = false
                        }
                } else if signInViewModel.loginTab == .signIn {
                    SignInView(userIsLoggedIn: $signInViewModel.userIsLoggedIn, showSignUpView: $signInViewModel.showSignUpView, loginTab: $signInViewModel.loginTab)
                        .onAppear {
                            firebaseManager.error = nil
                            firebaseManager.loading = false
                        }
                } else if signInViewModel.loginTab == .preview {
                    ContentView(triggerNextPage: signInViewModel.triggerNextPage)
                        .onAppear {
                            firebaseManager.error = nil
                            firebaseManager.loading = false
                        }
                }
            } else {
                HStack() {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .frame(width: 50, height: 83)
                        .aspectRatio(contentMode: .fill)
                        .padding(.trailing, 8)
                        .shadow(radius: 3)
                    Text("EasyMeal")
                        .bold()
                        .foregroundColor(custGreen)
                        .font(.system(size: 45))
                    Spacer()
                }
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                isActive = true
            }
        }
        
    }
}
    
