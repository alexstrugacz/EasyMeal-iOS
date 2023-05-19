import SwiftUI

struct Recipes: View {
    @State var showHello = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    showHello.toggle()
                }) {
                    Image(systemName: "slider.horizontal.3") // This is a built-in SwiftUI filter icon
                        .resizable()
                        .foregroundColor(Color(hex:"#139c67"))
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                        .padding(.leading, 20)
                        
                    
                }
                .padding()

                Spacer()

                Text("Recipes")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .offset(x:-50)

                Spacer()
            }
            .offset(y: 20)
            
            HStack{
                if showHello {
                    Button(action: {
                        
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(hex:"#139c67"))
                            .frame(width: 229, height: 30)
                            .overlay(
                                HStack {
                                    Text("Calories Least")
                                        .foregroundColor(.white)
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.white)
                                    Text("Greatest")
                                        .foregroundColor(.white)
                                }
                            )
                    }
                    .padding(.leading, 20)
                    .padding(.top,5)
                }
                Spacer()
            }
            
            HStack{
                if showHello {
                    Button(action: {
                        
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(hex:"#139c67"))
                            .frame(width: 229, height: 30)
                            .overlay(
                                HStack {
                                    Text("Calories Greatest")
                                        .foregroundColor(.white)
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.white)
                                    Text("Least")
                                        .foregroundColor(.white)
                                }
                            )
                    }
                    .padding(.leading, 20)
                }
                Spacer()
            }
            
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 35) {
                    ForEach(0..<10) { index in
                        VStack {
                            RecipeImageButton(index: index)
                            Text("Recipe Recipe\(index + 1)")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
            }
        }
    }
}

struct RecipeImageButton: View {
    let index: Int
    
    var body: some View {
        NavigationLink(destination: RecipeInfo()) {
            Image("recipe\(index)")
                .resizable()
                .frame(width: 160, height: 160)
                .background(Color.yellow)
                .cornerRadius(10)
        }
    }
}

struct Recipes_Preview: PreviewProvider {
    static var previews: some View {
        Recipes()
    }
}
