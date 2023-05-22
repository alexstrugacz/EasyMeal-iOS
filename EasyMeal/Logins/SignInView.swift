//
//  SignInView.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/21/23.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var logoOpacity = 0.0
    @Binding var userIsLoggedIn:Bool
    @Binding var showSignUpView: Bool
    @Binding var loginTab: LoginTabs
    @EnvironmentObject var firebaseManager: FirebaseManager
    var body: some View {
        ZStack {
            Color.white
            VStack() {
                HStack() {
                    Image("logo")
                        .resizable()
                        .frame(width: 50, height: 83)
                        .aspectRatio(contentMode: .fill)
                        .padding(.trailing, 8)
                        .opacity(logoOpacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 2.0)) {
                                logoOpacity = 1
                            }
                        }
                    
                    
                        .shadow(radius: 3)
                    Text("EasyMeal")
                        .bold()
                        .foregroundColor(custGreen)
                        .font(.system(size: 45))
                }.frame(maxWidth: .infinity, alignment: .leading).offset(x: 25)
                    .onAppear {
                        withAnimation(.easeIn(duration: 2.0)) {
                        }
                    }
                
                Rectangle()
                    .foregroundColor(Color(hex: "efefef"))
                    .frame(width: 350, height: 50)
                    .cornerRadius(10)
                
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(Color(hex: "747474"))
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    
                }.offset(x: 50, y: -38)
                
                Rectangle()
                    .foregroundColor(Color(hex: "efefef"))
                    .frame(width: 350, height: 50)
                    .cornerRadius(10)
                    .offset(y: -8)
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(Color(hex: "747474"))
                    
                    HStack {
                        SecureField("Password", text: $password)
                        Image(systemName: "eye")
                            .foregroundColor(Color(hex: "747474"))
                    }
                }.offset(x: 50, y: -46)
                
                
                HStack {
                    Button(action: {
                        //Forgot password func
                    }) {
                        Text("Forgot password?")
                            .bold()
                            .foregroundColor(Color(hex: "7B7A7A"))
                            .font(.footnote)
                            .offset(y: -30)
                            .underline()
                    }
                    
                    
                }.frame(width: 350, alignment: .leading)
                
                
                HStack {
                    Button(action: {
                        firebaseManager.signIn(email: email, password: password)
                        
                    }) {
                        Text("Log In")
                            .frame(width: 234, height: 50)
                            .cornerRadius(20)
                            .foregroundColor(Color.white)
                            .bold()
                    }
                    .frame(width: 230, height: 50)
                    .background(custGreen)
                    .cornerRadius(10)
                    
                    Button(action: {
                        loginTab = .signUp
                    }) {
                        Text("I'm New")
                            .frame(height: 50)
                            .cornerRadius(20)
                            .foregroundColor(Color(hex: "747474"))
                            .bold()
                        
                    }
                    .frame(width: 110, height: 50)
                    .background(Color(hex: "efefef"))
                    .cornerRadius(10)
                    
                    
                    
                }.frame(width: 350, height: 50)
                
                Button(action: {
                    // Sign in with apple functionality
                }) {
                    Image(systemName: "apple.logo")
                        .foregroundColor(Color.white)
                    Text("Sign In with Apple")
                        .frame(height: 50)
                        .cornerRadius(20)
                        .foregroundColor(Color.white)
                        .bold()
                }
                .frame(width: 350, height: 50)
                .background(Color.black)
                .cornerRadius(10)
                
            }
            .frame(height: 500, alignment: .top)
        }.ignoresSafeArea().opacity(logoOpacity)
            .onAppear {
                withAnimation(.easeIn(duration: 0.6)) {
                    logoOpacity = 1
                }
            }
    }
}
