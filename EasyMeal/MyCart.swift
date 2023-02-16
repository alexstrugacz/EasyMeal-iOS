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
    
    var isCartEmpty: Bool {
            items.isEmpty
        }

    var body: some View {
        VStack {
            HStack {
                Text("My Cart")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                
            }
            .foregroundColor(Color.white.opacity(1))
            .offset(y:20)
            
            
            if isCartEmpty {
                    VStack {
                        Spacer()
                        Text("Your cart is empty!\nLet's go fill it up.")
                            .font(.headline)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(Color.white.opacity(1))
                        
                        
                        NavigationLink(destination: MainView(initialTab: .cooktop, content: {
                            Recipes()
                        }))
                        {
                            
                            Text("Browse Recipes")
                                .foregroundColor(.white)
                            
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .background(custGreen)
                        .cornerRadius(10)
                        Spacer()
                        
                        
                    }
                    .offset(y: 180)

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
                                    .foregroundColor(.white)
                                
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
                                
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if let index = self.items.firstIndex(where: { $0.id == item.id }) {
                                        self.items[index].isChecked.toggle()
                                    }
                                }
                                .gesture(
                                    DragGesture()
                                        .onChanged({ value in
                                            guard let index = self.items.firstIndex(where: { $0.id == item.id }) else {
                                                return
                                            }
                                            self.items[index].offset = value.translation.width
                                        })
                                        .onEnded({ value in
                                            guard let index = self.items.firstIndex(where: { $0.id == item.id }) else {
                                                return
                                            }
                                            if value.translation.width < -100 {
                                                withAnimation {
                                                    self.items.remove(at: index)
                                                }
                                            } else {
                                                self.items[index].offset = 0
                                            }
                                        })
                                )
                                .offset(x: item.offset)
                                .animation(.spring())
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
        var offset: CGFloat = 0
    }

    struct MyCart_Previews: PreviewProvider {
        static var previews: some View {
            MyCart()
        }
    }
}
