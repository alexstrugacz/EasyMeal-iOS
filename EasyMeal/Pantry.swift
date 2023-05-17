import SwiftUI

struct Pantry: View {
    @State private var items: [Ingredient]
    
    init() {
        let storedItems = UserDefaults.standard.array(forKey: "PantryItems") as? [[String: Any]] ?? []
        self._items = State(initialValue: storedItems.map { Ingredient(from: $0) })
    }
    
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
                                        saveItems()
                                    }
                                }) {
                                    Text(item.name)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 15)
                                        .frame(width:100, height: 35)
                                        .background(item.isChecked ? Color.green : Color.gray.opacity(0.6))
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
        
        init(name: String, isChecked: Bool, category: String) {
            self.name = name
            self.isChecked = isChecked
            self.category = category
        }
        
        init(from dictionary: [String: Any]) {
            self.name = dictionary["name"] as? String ?? ""
            self.isChecked = dictionary["isChecked"] as? Bool ?? false
            self.category = dictionary["category"] as? String ?? ""
        }
        
        func toDictionary() -> [String:        Any] {
            return [
                "name": name,
                "isChecked": isChecked,
                "category": category
            ]
        }
    }
    
    private func saveItems() {
        let encodedItems = items.map { $0.toDictionary() }
        UserDefaults.standard.set(encodedItems, forKey: "PantryItems")
    }
    
    struct Pantry_Preview: PreviewProvider {
        static var previews: some View {
            Pantry()
        }
    }
}


