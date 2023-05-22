
import SwiftUI
import Firebase

struct SignUp: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @Binding var loginTab: LoginTabs
    
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        if firebaseManager.isLoggedIn {
            MainView(initialTab: .mic, content: {})
        } else {
            NavigationView {
                VStack {
                    ZStack {
                        Color.white
                        
                        VStack {
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
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .offset(x: 35)
                            
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
                            }
                            .offset(x: 50, y: -39)
                            
                            Rectangle()
                                .foregroundColor(Color(hex: "efefef"))
                                .frame(width: 350, height: 50)
                                .cornerRadius(10)
                                .offset(y: -8)
                            
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(Color(hex: "747474"))
                                
                                SecureField("Password", text: $password)
                                
                                Image(systemName: "eye")
                                    .foregroundColor(Color(hex: "747474"))
                            }
                            .offset(x: 50, y: -46)
                            
                            Rectangle()
                                .foregroundColor(Color(hex: "efefef"))
                                .frame(width: 350, height: 50)
                                .cornerRadius(10)
                                .offset(y: -20)
                            
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(Color(hex: "747474"))
                                
                                SecureField("Confirm Password", text: $password)
                                
                                Image(systemName: "eye")
                                    .foregroundColor(Color(hex: "747474"))
                            }
                            .offset(x: 50, y: -58)
                            
                            HStack {
                                Button(action: {
                                    firebaseManager.signUp(email: email, password: password)
                                }) {
                                    Text("Sign Up")
                                        .frame(width: 234, height: 50)
                                        .cornerRadius(20)
                                        .foregroundColor(Color.white)
                                        .bold()
                                }
                                .frame(width: 350, height: 50)
                                .background(custGreen)
                                .cornerRadius(10)
                                .offset(y: -15)
                            }
                            .frame(width: 350, height: 50)
                            
                            Button(action: {
                                // Sign up with apple functionality
                            }) {
                                Image(systemName: "apple.logo")
                                    .foregroundColor(Color.white)

                                Text("Sign Up with Apple")
                                    .frame(height: 50)
                                    .cornerRadius(20)
                                    .foregroundColor(Color.white)
                                    .bold()
                            }
                            .frame(width: 350, height: 50)
                            .background(Color.black)
                            .cornerRadius(10)
                            .offset(y: -15)
                            VStack {
                                Text("By using EasyMeal, you agree to our Terms of Service")
                                    .bold()
                                    .foregroundColor(Color(hex: "7B7A7A"))
                                    .font(.caption)
                                    .offset(y: -15)
                                
                                Button {
                                    loginTab = .signIn
                                } label: {
                                    Text("Back to Sign In")
                                        .frame(width: 234, height: 50)
                                        .cornerRadius(20)
                                        .foregroundColor(.blue)
                                        .bold()
                                }
                            }
                        }
                        .frame(height: 500, alignment: .top)
                    }
                    .ignoresSafeArea()
                }
            }
        }
    }
}

