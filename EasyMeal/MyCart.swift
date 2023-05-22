import SwiftUI


struct MyCart: View {
    
    var openRecipes: () -> Void
    
    @State private var isShowingSettings = false
    
    @ObservedObject var myCartViewModel: MyCartViewModel
    
    init(newOpenRecipes: @escaping () -> Void) {
        openRecipes = newOpenRecipes
        myCartViewModel = MyCartViewModel(newOpenRecipes: newOpenRecipes)
        
    }

    
    var body: some View {
        VStack{
            
            VStack{
                HStack(alignment:.center){
                    
                    Spacer()
                
                    Text("My Cart")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.leading, 35)

                    Spacer()
                    Button(action: {
                        self.isShowingSettings.toggle()

                    }) {
                        ZStack {
                            Image("3dots")
                                .resizable()
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        .frame(width: 35, height: 35)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 25)
                
                if isShowingSettings {
                    HStack {
                        Button(action: {
                            // Mark All Complete button action
                            myCartViewModel.checkItems()
                        }) {
                            ZStack {
                                HStack() {
                                    Image(systemName: "checkmark")
                                    Text("Check Mark All")
                                }
                                .foregroundColor(custGreen)
                                .padding(.top,10)
                                .padding(.leading,20)
                            }.padding(10)

                        }
                        
                        Spacer()
                        
                        Button(action: {
                            myCartViewModel.deleteChecked()
                        }) {
                            ZStack {
                                HStack {
                                    Image(systemName: "trash")
                                    Text("Delete Checked")

                                }
                                .foregroundColor(Color(hex: "#ff0800"))
                                .padding(.top,10)
                                .padding(.trailing,20)
                            }.padding(10)

                        }
                    }
//                    ZStack {
//                        Color.gray.opacity(0.0)
//                            //.ignoresSafeArea()
//                            .frame(height: 150)
//                            //.frame(width: UIScreen.main.bounds.width)
//
//                        VStack(alignment: .leading, spacing: 20) {
                            

//                            Button(action: {
//                                // Shop Online button action
//                            }) {
//                                HStack {
//                                    Image(systemName: "cart")
//                                    Text("Shop Online")
//                                }
//                            }
//                            .background(
//                                RoundedRectangle(cornerRadius: 5)
//                                    .fill(Color.gray.opacity(0.2))
//                            )
                            
//                            Button(action: {
//                                // Mark All Complete button action
//                                var i = 0
//                                while(i < items.count) {
//                                    if(items[i].isChecked == false){
//                                        self.items[i].isChecked.toggle()
//                                        print(i)
//                                        i+=1
//
//                                    }
//                                }
//                            }) {
//                                HStack() {
//                                    Image(systemName: "checkmark")
//                                    Text("Check Mark All")
//
//                                }
//                                .foregroundColor(.white)
//
//                            }
//
//                            Button(action: {
//                                // Mark All Complete button action
//                                self.items.removeAll(where: { $0.isChecked })
//                            }) {
//                                HStack {
//                                    Image(systemName: "trash")
//                                    Text("Delete Checked")
//
//                                }
//                                .foregroundColor(.white)
//
//                            }
//
                            
//                            Button(action: {
//                                // Share button action
//                                let itemsText = items.map({ "\($0.name) (\($0.size))" }).joined(separator: "\n")
//                                    let message = "My shopping list:\n\(itemsText)"
//                                    let items: [Any] = [message]
//                                    let excludedActivities: [UIActivity.ActivityType] = [.postToFacebook, .postToTwitter] // Add any additional excluded activity types here
//                                    let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
//                                    activityViewController.excludedActivityTypes = excludedActivities
//
//                                    UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
//                            }) {
//                                HStack {
//                                    Image(systemName: "square.and.arrow.up")
//                                    Text("Share")
//                                }
//                                .background(
//                                    RoundedRectangle(cornerRadius: 5)
//                                        .fill(Color.gray.opacity(0.2))
//                                )
//                                .foregroundColor(.white)
//
//                            }
//                        }
//                        .foregroundColor(.black)
//                        .offset(x: -100)
                        
                        
//                    }
                    
//                    .background(custGreen)
//
//                    .frame(height: 150)
//                    .frame(width: UIScreen.main.bounds.width)
//                    .offset(y: 10)
                    
                }
                
                if (myCartViewModel.items.count == 0) {
                    VStack {
                        Spacer()
                        Text("Your cart is empty!\nLet's go fill it up.")
                            .font(.headline)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(Color.white.opacity(1))
                        
                        
                        Button {
                            openRecipes()
                        } label: {
                            
                            Text("Browse Recipes")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 30)
                                .background(custGreen)
                                .cornerRadius(10)
                        }

                        Spacer()
                        
                        
                    }
                    .offset(y: 180)

                }
                
            }

            VStack {
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(myCartViewModel.items, id: \.id) { item in
                            Button {
                                if let index = myCartViewModel.items.firstIndex(where: { $0.id == item.id }) {
                                    myCartViewModel.items[index].isChecked.toggle()
                                    myCartViewModel.saveItems()
                                }
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(height: 60)
                                        .foregroundColor(.white)
                                    
                                    HStack {
                                        if item.isChecked {
                                            Image(systemName: "checkmark.square")
                                                .foregroundColor(.green)
                                                .padding(.leading, 15) // add leading padding
                                        } else {
                                            Image(systemName: "square")
                                                .foregroundColor(.black)
                                                .padding(.leading, 15) // add leading padding
                                        }
                                        
                                        Text(item.name)
                                            .foregroundColor(.black)
                                            .font(.subheadline)
                                        
                                        Spacer()
                                    }
                                    .padding(.vertical, 10)
                                    
                                    .contentShape(Rectangle())
                                }
                                .cornerRadius(10)
                                .gesture(
                                    DragGesture()
                                        .onChanged({ value in
                                            guard let index = myCartViewModel.items.firstIndex(where: { $0.id == item.id }) else {
                                                return
                                            }
                                            myCartViewModel.items[index].offset = value.translation.width
                                            
                                        })
                                        .onEnded({ value in
                                            guard let index = myCartViewModel.items.firstIndex(where: { $0.id == item.id }) else {
                                                return
                                            }
                                            if value.translation.width < -100 {
                                                withAnimation {
                                                    myCartViewModel.items.remove(at: index)
                                                }
                                            } else {
                                                myCartViewModel.items[index].offset = 0
                                            }
                                            myCartViewModel.saveItems()
                                        })
                                )
                                .offset(x: item.offset)
                                .animation(.spring())
                            }
                        }
                        
                        
                    
                        
                    }3
                    .padding(.bottom, 300)
                    
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
    var offset: CGFloat = 0
    
    init(name: String, isChecked: Bool) {
        self.name = name
        self.isChecked = isChecked
    }
    
    init(from dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.isChecked = dictionary["isChecked"] as? Bool ?? false
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "isChecked": isChecked,
            "offset": offset
        ]
    }
}


