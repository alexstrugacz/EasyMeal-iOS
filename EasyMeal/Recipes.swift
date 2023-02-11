import SwiftUI

struct Recipes: View {
    @State var showView = false
    
    var body: some View {
        ScrollView {
            
            Text("Recipes")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            
            VStack(spacing: 20) {
                Text("Recently Added")
                    .bold()
                    .multilineTextAlignment(.leading)
                    .offset(x: -110, y: 10)
                    .font(.system(size: 23))
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(0..<10) { index in
                            VStack(spacing: 8) {
                                VStack {
                                    Button(action: {
                                        print("Button tapped: \(index)")
                                    }) {
                                        Text("Button \(index)")
                                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                    }
                                    .frame(width: 160, height: 160)
                                    .background(Color.yellow)
                                    .cornerRadius(10)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Title \(index)")
                                        .font(.headline)
                                    HStack {
                                        Text("Subtitle A \(index)")
                                            .font(.subheadline)
                                        Text("Subtitle B \(index)")
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            VStack(spacing: 20) {
                Text("Recently Added")
                    .bold()
                    .multilineTextAlignment(.leading)
                    .offset(x: -110, y: 10)
                    .font(.system(size: 23))
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(0..<10) { index in
                            VStack(spacing: 8) {
                                VStack {
                                    Button(action: {
                                        print("Button tapped: \(index)")
                                    }) {
                                        Text("Button \(index)")
                                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                    }
                                    .frame(width: 160, height: 160)
                                    .background(Color.yellow)
                                    .cornerRadius(10)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Title \(index)")
                                        .font(.headline)
                                    HStack {
                                        Text("Subtitle A \(index)")
                                            .font(.subheadline)
                                        Text("Subtitle B \(index)")
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            VStack(spacing: 20) {
                Text("Recently Added")
                    .bold()
                    .multilineTextAlignment(.leading)
                    .offset(x: -110, y: 10)
                    .font(.system(size: 23))
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(0..<10) { index in
                            VStack(spacing: 8) {
                                VStack {
                                    Button(action: {
                                        print("Button tapped: \(index)")
                                    }) {
                                        Text("Button \(index)")
                                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                    }
                                    .frame(width: 160, height: 160)
                                    .background(Color.yellow)
                                    .cornerRadius(10)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Title \(index)")
                                        .font(.headline)
                                    HStack {
                                        Text("Subtitle A \(index)")
                                            .font(.subheadline)
                                        Text("Subtitle B \(index)")
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }
    }
}
