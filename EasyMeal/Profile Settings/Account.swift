//
//  Account.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 3/1/23.
//

import SwiftUI
import FirebaseAuth

struct Account: View {
    @State private var currentUserEmail: String = ""

    var body: some View {
        VStack {
            Text("Account")
                .font(.largeTitle)
            
            Text("Email: \(currentUserEmail)")
                .font(.headline)
                
        }
        .frame(alignment: .leading)
        .padding(.bottom, 100)
        
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
