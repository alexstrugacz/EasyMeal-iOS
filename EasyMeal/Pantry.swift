import SwiftUI

struct Pantry: View {
    @State private var items = [
        Ingredient(name: "Chicken", isChecked: false, category: "Meat"),
        Ingredient(name: "Carrot", isChecked: false, category: "Vegetables"),
        Ingredient(name: "Bread Crumb", isChecked: false, category: "Pantry"),
        Ingredient(name: "Pepper", isChecked: false, category: "Vegetables"),
        Ingredient(name: "Fish", isChecked: false, category: "Meat"),
        Ingredient(name: "Tomato", isChecked: false, category: "Vegetables"),
        Ingredient(name: "Salt", isChecked: false, category: "Pantry"),
        Ingredient(name: "Cucumber", isChecked: false, category: "Vegetables"),
        Ingredient(name: "Asparagus", isChecked: false, category: "Vegetables")

    ]
    
    var groupedItems: [String: [Ingredient]] {
        Dictionary(grouping: items, by: { $0.category })
    }
    
    let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var searchText = ""

    var body: some View {
        VStack{

            
            VStack() {
                
                TextField("add ingredients", text: $searchText)
                    .padding(.horizontal, 20)
                    .frame(width: 200, height: 40)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .textFieldStyle(PlainTextFieldStyle())
                    .multilineTextAlignment(.center)
                
            }
            

            ScrollView {
                ForEach(groupedItems.keys.sorted(), id: \.self) { category in
                    VStack(alignment: .leading) {
                        Text(category)
                            .font(.subheadline)
                            .padding(.leading, 20)
                            .bold()
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))], spacing: 5) {
                            ForEach(groupedItems[category]!, id: \.id) { item in
                                Button(action: {
                                    if let index = items.firstIndex(where: { $0.id == item.id }) {
                                        items[index].isChecked.toggle()
                                    }
                                }) {
                                    Text(item.name)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 15)
                                        .frame(width:100, height: 35)
                                        .background(item.isChecked ? custGreen : Color.gray.opacity(0.6))
                                        .cornerRadius(60)
                                        .minimumScaleFactor(0.5) // Set a minimum scale factor to allow the text to scale down
                                        .fixedSize(horizontal: true, vertical: false)
                                        .font(.system(size: 15)) // Set the initial font size
                                }

                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 5)
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    
                    )
                }
            }
            .offset(y: 10)
            .padding(.horizontal, 20)
            .shadow(radius: 3)
            Spacer()
        }
    }
    
    struct Ingredient: Identifiable, Hashable {
        let id = UUID()
        var name: String
        var isChecked: Bool
        var category: String
    }
    
    struct Pantry_Preview: PreviewProvider {
        static var previews: some View {
            Pantry()
        }
    }
}

