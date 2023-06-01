import SwiftUI
import FirebaseAuth

struct Profile: View {
    
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        if firebaseManager.isLoggedIn == false {
            SignIn()
        } else {
            NavigationView {
                List {
//                    NavigationLink(destination: General()) {
//                        Label("General", systemImage: "gear")
//                    }
                    NavigationLink(destination: Account()) {
                        Label("Account", systemImage: "person")
                    }
                    NavigationLink(destination: RecipesSaved()) {
                        Label("Recipes Saved", systemImage: "book.closed")
                    }
//                    NavigationLink(destination: Notifications()) {
//                        Label("Notifications", systemImage: "bell")
//                    }
//                    NavigationLink(destination: Appearance()) {
//                        Label("Appearance", systemImage: "paintbrush")
//                    }
//                    NavigationLink(destination: Privacy()) {
//                        Label("Privacy", systemImage: "lock")
//                    }
//                    NavigationLink(destination: Help___Support()) {
//                        Label("Help & Support", systemImage: "questionmark.circle")
//                    }
//                    NavigationLink(destination: About()) {
//                        Label("About", systemImage: "info.circle")
//                    }
                    
                    
                    Section {
                        Button(action: {
                            firebaseManager.signOut()
                        }) {
                            Label("Log Out", systemImage: "arrow.left.square")
                                .foregroundColor(.red)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("Profile")
            }
        }
    }
}

