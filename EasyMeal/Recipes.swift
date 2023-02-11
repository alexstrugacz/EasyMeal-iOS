//
//  Recipes.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 2/10/23.
//

import SwiftUI

struct Recipes: View {
    @State var showView = false

    var body: some View {
            VStack {
                Text("Recipes")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                
            VStack(spacing: 20) {
                            ScrollView(.horizontal) {
                                HStack(spacing: 20) {
                                    ForEach(0..<10) { index in
                                        Button(action: {
                                            print("Button tapped: \(index)")
                                        }) {
                                            Text("Button \(index)")
                                        }
                                        .frame(width: 60, height: 60)
                                        .background(Color.yellow)
                                        .cornerRadius(30)
                                    }
                                }
                            }
                            ScrollView(.horizontal) {
                                HStack(spacing: 20) {
                                    ForEach(10..<20) { index in
                                        Button(action: {
                                            print("Button tapped: \(index)")
                                        }) {
                                            Text("Button \(index)")
                                        }
                                        .frame(width: 60, height: 60)
                                        .background(Color.yellow)
                                        .cornerRadius(30)
                                    }
                                }
                            }
                            ScrollView(.horizontal) {
                                HStack(spacing: 20) {
                                    ForEach(20..<30) { index in
                                        Button(action: {
                                            print("Button tapped: \(index)")
                                        }) {
                                            Text("Button \(index)")
                                        }
                                        .frame(width: 60, height: 60)
                                        .background(Color.yellow)
                                        .cornerRadius(30)
                                    }
                                }
                            }
                        }
            }
    }
}

