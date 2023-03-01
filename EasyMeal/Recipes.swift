import SwiftUI

struct Recipes: View {
    @State var showView = false
    
    var body: some View {
        VStack{
            VStack {
                Text("Recipes")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                
                
            }
            .foregroundColor(Color.white.opacity(1))
            .offset(y:20)
            
            ScrollView(showsIndicators: false) {
                
                
                
                VStack(spacing: 35) {
                    Text("Recently Added")
                        .bold()
                        .multilineTextAlignment(.leading)
                        .offset(x: -105, y: 25)
                        .font(.system(size: 23))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<10) { index in
                                VStack(spacing: 8) {
                                    VStack {
                                        NavigationLink(destination: RecipeInfo()) {
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
                                    .offset(x: 5)
                                    
                                }
                            }
                        }
                    }
                    .offset(x: 5)
                }
                
                VStack(spacing: 35) {
                    Text("Most Popular")
                        .bold()
                        .multilineTextAlignment(.leading)
                        .offset(x: -110, y: 25)
                        .font(.system(size: 23))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<10) { index in
                                VStack(spacing: 8) {
                                    VStack {
                                        NavigationLink(destination: RecipeInfo()) {
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
                                    .offset(x: 5)
                                    
                                }
                            }
                        }
                    }
                    .offset(x: 5)
                }
                
                VStack(spacing: 35) {
                    Text("Recommended")
                        .bold()
                        .multilineTextAlignment(.leading)
                        .offset(x: -105, y: 25)
                        .font(.system(size: 23))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<10) { index in
                                VStack(spacing: 8) {
                                    VStack {
                                        NavigationLink(destination: RecipeInfo()) {
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
                                    .offset(x: 5)
                                    
                                }
                            }
                        }
                    }
                    .offset(x: 5)
                }
                Spacer(minLength: 100)
                
            }
            
        }
        
        
    }

}
