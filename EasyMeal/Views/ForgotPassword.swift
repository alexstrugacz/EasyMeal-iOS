//
//  ForgotPassword.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 5/22/23.
//

import SwiftUI

struct ForgotPassword: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    @ObservedObject var forgotPasswordViewModel: ForgotPasswordViewModel
    
    init(closeTab: @escaping () -> Void) {
        forgotPasswordViewModel = ForgotPasswordViewModel(closeTab: closeTab)
    }

    var body: some View {
        if forgotPasswordViewModel.passwordResetSent {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Password reset sent.")
                    Spacer()
                }
                Spacer()
            }
            
        } else {
            VStack(alignment: .leading) {
                
                HStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 50, height: 83)
                        .aspectRatio(contentMode: .fill)
                        .shadow(radius: 3)
                    
                    Text("EasyMeal")
                        .bold()
                        .foregroundColor(custGreen)
                        .font(.system(size: 45))
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
//                Text("Forgot Password")
//                    .bold()
//                    .foregroundColor(.black)
//                    .font(.system(size: 30))
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(Color(hex: "747474"))
                    TextField("Email", text: $forgotPasswordViewModel.email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                }
                
                Button(action: {
                    firebaseManager.resetPassword(email: forgotPasswordViewModel.email) {
                        forgotPasswordViewModel.passwordResetSent = true
                    } onError: {
                        forgotPasswordViewModel.passwordResetSent = false
                    }
                    
                    
                }) {
                    Text("Reset Password")
                        .frame(width: 234, height: 50)
                        .cornerRadius(20)
                        .foregroundColor(Color.white)
                        .bold()
                }
                .background(custGreen)
                .cornerRadius(10)
                .padding(.top, 20)
                Spacer()
                
            }
            .padding(30)
        }
        
    }
}

