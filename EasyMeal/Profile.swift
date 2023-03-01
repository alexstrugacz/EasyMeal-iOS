//
//  Profile.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 2/10/23.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        VStack{
            
            VStack {
                Text("Profile")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                
                
            }
            .foregroundColor(Color.white.opacity(1))
            .offset(y:20)
            
            NavigationView {
                List {
                    NavigationLink(destination: General()) {
                        HStack {
                            Image(systemName: "gear")
                            Text("General")
                        }
                    }
                    
                    NavigationLink(destination: Account()) {
                        HStack {
                            Image(systemName: "person")
                            Text("Account")
                        }
                    }
                    
                    NavigationLink(destination: Notifications()) {
                        HStack {
                            Image(systemName: "bell")
                            Text("Notifications")
                        }
                    }
                    
                    NavigationLink(destination: Appearance()) {
                        HStack {
                            Image(systemName: "paintbrush")
                            Text("Appearance")
                        }
                    }
                    
                    NavigationLink(destination: Privacy()) {
                        HStack {
                            Image(systemName: "lock")
                            Text("Privacy")
                        }
                    }
                    
                    NavigationLink(destination: Help___Support()) {
                        HStack {
                            Image(systemName: "questionmark.circle")
                            Text("Help & Support")
                        }
                    }
                    
                    NavigationLink(destination: About()) {
                        HStack {
                            Image(systemName: "info.circle")
                            Text("About")
                        }
                    }
                    NavigationLink(destination: Text("Logout")) {
                        HStack {
                            Image(systemName: "arrow.left.square")
                            Text("Logout")
                        }
                        .foregroundColor(.red)
                    }
                    
                }
                .padding(.vertical, 10)
            }
            
        }
        
    }
}
