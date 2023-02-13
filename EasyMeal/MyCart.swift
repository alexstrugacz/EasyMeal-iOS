import SwiftUI

struct MyCart: View {
    @State private var items = [
        ShoppingItem(name: "Apples", isChecked: false),
        ShoppingItem(name: "Bananas", isChecked: false),
        ShoppingItem(name: "Oranges", isChecked: false),
        ShoppingItem(name: "Pears", isChecked: false)
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.id) { item in
                    Section() {
                        HStack {
                            Button(action: {
                                if let index = self.items.firstIndex(where: { $0.id == item.id }) {
                                    self.items[index].isChecked.toggle()
                                }
                            }) {
                                if item.isChecked {
                                    Image(systemName: "checkmark.square")
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "square")
                                        .foregroundColor(.black)
                                }
                            }
                            Text(item.name)
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            
            .navigationBarTitle("Shopping List")
        }
    }
}

struct ShoppingItem: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var isChecked: Bool
}

struct MyCart_Previews: PreviewProvider {
    static var previews: some View {
        MyCart()
    }
}

