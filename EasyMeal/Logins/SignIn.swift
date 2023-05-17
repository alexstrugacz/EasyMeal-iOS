//
//  SignIn.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 2/10/23.
//

import SwiftUI
import Firebase

struct SignIn: View {
    @State var showView = false
    @State var showView2 = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var userIsLoggedIn = false
    
    var body: some View {
        if userIsLoggedIn {
                MyCart()
        } else {
            content
        }
    }
    
    var content: some View {
        ZStack {
            Color.white
            VStack() {
                HStack() {
                    Image("logo")
                        .resizable()
                        .frame(width: 50, height: 83)
                        .aspectRatio(contentMode: .fill)
                        
                        .shadow(radius: 3)
                    Text("EasyMeal")
                        .bold()
                        .foregroundColor(custGreen)
                        .font(.system(size: 45))
                }.frame(maxWidth: .infinity, alignment: .leading).offset(x: 35)
                
                Rectangle()
                    .foregroundColor(Color(hex: "efefef"))
                    .frame(width: 350, height: 50)
                    .cornerRadius(10)
                
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(Color(hex: "747474"))
                    TextField("Email", text: $email)
                        
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
                        login()
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
                        // sign up func
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
            .onAppear {
                Auth.auth().addStateDidChangeListener() { auth, user in
                    if user != nil { //not working
                        userIsLoggedIn.toggle()
                    }
                }
            }
        }.ignoresSafeArea()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            
        }
    }
}

    
    struct SignIn_Previews: PreviewProvider {
        static var previews: some View {
            SignIn()
        }
    }
