import SwiftUI

struct Recipes: View {
    @State var showView = false
    
    var body: some View {
        VStack {
            VStack {
                Text("Recipes")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
            }
            .foregroundColor(Color.white.opacity(1))
            .offset(y: 20)
            
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
                .padding(.top, 30)
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

