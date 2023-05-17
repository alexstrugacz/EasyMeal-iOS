import SwiftUI
import FirebaseAuth

struct Profile: View {
    var body: some View {
        
        @ObservedObject var firebaseManager = FirebaseManager()
        
        NavigationView {
            List {
                    NavigationLink(destination: General()) {
                        Label("General", systemImage: "gear")
                    }
                    NavigationLink(destination: Account()) {
                        Label("Account", systemImage: "person")
                    }
                    NavigationLink(destination: Notifications()) {
                        Label("Notifications", systemImage: "bell")
                    }
                    NavigationLink(destination: Appearance()) {
                        Label("Appearance", systemImage: "paintbrush")
                    }
                    NavigationLink(destination: Privacy()) {
                        Label("Privacy", systemImage: "lock")
                    }
                    NavigationLink(destination: Help___Support()) {
                        Label("Help & Support", systemImage: "questionmark.circle")
                    }
                    NavigationLink(destination: About()) {
                        Label("About", systemImage: "info.circle")
                    }
                
                
                Section {
                    Button(action: {
                        firebaseManager.signOut()
                    }) {
                        Label("Log Out", systemImage: "arrow.left.square")
                            .foregroundColor(.red)
                    }
                    .onAppear {
                                // Check if user is already logged in
                                if Auth.auth().currentUser != nil {
                                    firebaseManager.isLoggedIn = true
                                }
                            }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Profile")
        }
    }
}

