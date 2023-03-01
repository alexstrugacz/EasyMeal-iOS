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
    
    @State private var isShowingSettings = false
    
    var body: some View {
        VStack{
            
            VStack{
                HStack{
                    
                    Spacer()
                    Text("My Cart")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.leading, 42)

                    Spacer()
                    Button(action: {
                        self.isShowingSettings.toggle()
                        
                    }) {
                        Image("3dots")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            
                    }
                    .padding(.trailing, 10)
                    
                }
                .offset(y:20)
                
                if isShowingSettings {
                    ZStack {
                        Color.gray.opacity(0.0)
                            .ignoresSafeArea()
                            .frame(height: 150)
                            .frame(width: UIScreen.main.bounds.width)
                    
                        VStack(spacing: 20) {

                            Button(action: {
                                // Shop Online button action
                            }) {
                                HStack {
                                    Image(systemName: "cart")
                                    Text("Shop Online")
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.gray.opacity(0.2))
                            )
                            Button(action: {
                                // Mark All Complete button action
                                var i = 0
                                while(i < items.count) {
                                    if(items[i].isChecked == false){
                                        self.items[i].isChecked.toggle()
                                        print(i)
                                        i+=1
                                        
                                    }
                                }
                            }) {
                                HStack {
                                    Image(systemName: "checkmark")
                                    Text("Check Mark All")
                                    
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.gray.opacity(0.2))
                            )
                            
                            Button(action: {
                                // Mark All Complete button action
                                self.items.removeAll(where: { $0.isChecked })
                            }) {
                                HStack {
                                    Image(systemName: "trash")
                                    Text("Delete Checked")
                                    
                                }
                                
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.gray.opacity(0.2))
                            )
                            
                            Button(action: {
                                // Share button action
                                let itemsText = items.map({ "\($0.name) (\($0.size))" }).joined(separator: "\n")
                                    let message = "My shopping list:\n\(itemsText)"
                                    let items: [Any] = [message]
                                    let excludedActivities: [UIActivity.ActivityType] = [.postToFacebook, .postToTwitter] // Add any additional excluded activity types here
                                    let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
                                    activityViewController.excludedActivityTypes = excludedActivities
                                    
                                    UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
                            }) {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                    Text("Share")
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.gray.opacity(0.2))
                                )
                            }
                        }
                        .foregroundColor(.black)

                        
                    }
                    .frame(height: 150)
                    .frame(width: UIScreen.main.bounds.width)
                    .offset(y: 10)
                }

                
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
                
            }
            
            VStack {
                
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
                .onTapGesture {
                    isShowingSettings = false
                }
                
                .padding(.horizontal, 20)
                
                Spacer()
                
                
                
            }
            .shadow(radius: 3)
            
        }
        
    }
    
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

