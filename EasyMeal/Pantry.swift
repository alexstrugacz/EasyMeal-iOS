import SwiftUI

struct Pantry: View {
    @State private var items = [
        Ingredient(name: "Chicken", isChecked: false, category: "Meat"),
        Ingredient(name: "Carrot", isChecked: false, category: "Vegetables"),
        Ingredient(name: "Bread Crumb", isChecked: false, category: "Pantry"),
        Ingredient(name: "Pepper", isChecked: false,category: "Vegetables"),
        Ingredient(name: "Fish", isChecked: false,category: "Meat"),
        Ingredient(name: "Tomato", isChecked: false,category: "Vegetables"),
        Ingredient(name: "Salt", isChecked: false,category: "Pantry"),
        Ingredient(name: "Cucumber", isChecked: false,category: "Vegetables"),
        Ingredient(name: "Asparagus", isChecked: false,category: "Vegetables")

    ]
    
    var groupedItems: [String: [Ingredient]] {
        Dictionary(grouping: items, by: { $0.category })
    }
    
    let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack{
            VStack{
                Text("My Cart")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .foregroundColor(Color.white.opacity(1))
                    .offset(y:20)
            }
            
            ScrollView {
                ForEach(groupedItems.keys.sorted(), id: \.self) { category in
                    VStack(alignment: .leading) {
                        Text(category)
                            .font(.subheadline)
                            .padding(.leading, 20)
                            .bold()
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))], spacing: 10) {
                            ForEach(groupedItems[category]!, id: \.id) { item in
                                Button(action: {
                                    if let index = items.firstIndex(where: { $0.id == item.id }) {
                                        items[index].isChecked.toggle()
                                    }
                                }) {
                                    Text(item.name)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 5)
                                        .frame(height: 35)
                                        .background(item.isChecked ? Color.green : Color.gray.opacity(0.6))
                                        .cornerRadius(60)
                                        .fixedSize(horizontal: true, vertical: false) // Add this line
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

