import SwiftUI

struct Profile: View {
    var body: some View {
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
                        // Handle logout action
                    }) {
                        Label("Logout", systemImage: "arrow.left.square")
                            .foregroundColor(.red)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Profile")
        }
    }
}

