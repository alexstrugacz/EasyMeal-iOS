//
//  MainView.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 2/10/23.
//

import SwiftUI

struct MainView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            Pantry().tabItem {
                Image(systemName: "1.circle")
                Text("Pantry")
            }.tag(0)

            Recipes().tabItem {
                Image(systemName: "2.circle")
                Text("Recipes")
            }.tag(1)

            MyCart().tabItem {
                Image(systemName: "3.circle")
                Text("My Cart")
            }.tag(2)

            Profile().tabItem {
                Image(systemName: "4.circle")
                Text("Profile")
            }.tag(3)
        }
    }
}

