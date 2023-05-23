//
//  Account.swift
//  EasyMeal
//
//  Created by Alex Strugacz on 5/22/23.
//

import SwiftUI
import FirebaseAuth

struct Account: View {
    
    @State private var currentUserEmail: String = ""
    @EnvironmentObject var firebaseManager: FirebaseManager


    var body: some View {
        VStack(alignment: .leading) {
            Text("Account")
                .font(.largeTitle)
                .bold()
            
            Text("Email: \(currentUserEmail)")
                .font(.headline)
                .bold()
                .padding(.top, 1)
                
            Button(action: {
                firebaseManager.deleteAccount()
            }) {
                Text("Delete My Account")
            }
            .buttonStyle(.bordered)
            .foregroundColor(custGreen)
            .padding(.top)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.leading)
        
        
        
            
            .onAppear {
                // Retrieve the currently signed-in user's email
                if let currentUser = Auth.auth().currentUser {
                    currentUserEmail = currentUser.email ?? "No email found"
                } else {
                    currentUserEmail = "Not signed in"
                }
            }
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}
