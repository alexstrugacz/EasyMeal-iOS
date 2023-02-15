import SwiftUI

struct MyCart: View {
    @State private var items = [
        ShoppingItem(name: "Chicken", isChecked: false, size: "1 C."),
        ShoppingItem(name: "Carrots", isChecked: false, size: "0.5 lb."),
        ShoppingItem(name: "Bread Crumbs", isChecked: false, size: "Pinch"),
        ShoppingItem(name: "Peppers", isChecked: false, size: "2")
    ]
    
    var body: some View {
        VStack {
            Text("MyCart")
                .font(.title)
                .foregroundColor(.black)
                .padding()
            
            ScrollView {
                ForEach(items, id: \.id) { item in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 60)
                            .foregroundColor(custGray)

                        
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
                            .padding(.leading, 10)
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
                }
            }.padding(.horizontal, 20)
                .shadow(radius: 5)
        }
    }
    
    struct ShoppingItem: Identifiable, Hashable {
        let id = UUID()
        var name: String
        var isChecked: Bool
        var size: String
    }
    
    struct MyCart_Previews: PreviewProvider {
        static var previews: some View {
            MyCart()
        }
    }
}
