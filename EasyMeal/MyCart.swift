import SwiftUI

struct MyCart: View {
    @State private var items = [
        ShoppingItem(name: "Chicken", isChecked: false, size: "1 C.", category: "Meat"),
        ShoppingItem(name: "Carrots", isChecked: false, size: "0.5 lb.", category: "Vegetables"),
        ShoppingItem(name: "Bread Crumbs", isChecked: false, size: "Pinch", category: "Pantry"),
        ShoppingItem(name: "Peppers", isChecked: false, size: "2", category: "Vegetables")
    ]
    
    var groupedItems: [String: [ShoppingItem]] {
        Dictionary(grouping: items, by: { $0.category })
    }

    var body: some View {
        VStack {
            HStack {
                Text("My Cart")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
            }
            
            ScrollView {
                ForEach(groupedItems.keys.sorted(), id: \.self) { category in
                    VStack(alignment: .leading) {
                        Text(category)
                            .font(.subheadline)
                            .padding(.leading, 20)
                        ForEach(groupedItems[category]!, id: \.id) { item in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 60)
                                    .foregroundColor(custGray)
                                    .onTapGesture {
                                        if let index = self.items.firstIndex(where: { $0.id == item.id }) {
                                            self.items[index].isChecked.toggle()
                                        }
                                    }
                                
                                HStack {
                                    if item.isChecked {
                                        Image(systemName: "checkmark.square")
                                            .foregroundColor(.green)
                                            .padding(.leading, 30) // add leading padding
                                    } else {
                                        Image(systemName: "square")
                                            .foregroundColor(.black)
                                            .padding(.leading, 30) // add leading padding
                                    }
                                    
                                    Text(item.name)
                                        .font(.subheadline)
                                    
                                    Spacer()
                                    
                                    Text(item.size)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                }
                                .padding(.vertical, 10)
                            }
                            .cornerRadius(10)
                        }

                    }
                    
                }
                
            }
            
            .padding(.horizontal, 20)
            Spacer()
        }
        .shadow(radius: 3)

    }

    struct ShoppingItem: Identifiable, Hashable {
        let id = UUID()
        var name: String
        var isChecked: Bool
        var size: String
        var category: String
    }

    struct MyCart_Previews: PreviewProvider {
        static var previews: some View {
            MyCart()
        }
    }
}

