import SwiftUI

struct MainView<Content: View>: View {
    @State var isActive: Bool = false
    @State private var tabSelected: Tab = .refrigerator
    @State var displayingSpeakIngredients = false
    
    let destinationView: Content

    init(initialTab: Tab, @ViewBuilder content: () -> Content) {
        self.destinationView = content()
        self._tabSelected = State(initialValue: initialTab)
        UITabBar.appearance().isHidden = true
    }
    
    func displaySpeakIngredients() {
        displayingSpeakIngredients = true
    }
    
    func openCart() {
        tabSelected = .cart
    }
    
    func openRecipes() {
        tabSelected = .book
    }

    
    var body: some View {
        
        ZStack {
            if (isActive) {
                ZStack {
                    VStack {
                        TabView(selection: $tabSelected) {
                            if tabSelected == .refrigerator {
                                Pantry(speakIngredients: $displayingSpeakIngredients, displaySpeakIngredients: displaySpeakIngredients)
                                    .opacity(tabSelected == .refrigerator ? 1.0 : 0.0) // Set opacity based on tab selection
                                    .animation(.easeInOut)
                            } else if tabSelected == .book {
                                Recipes(openCart: openCart)
                                    .opacity(tabSelected == .book ? 1.0 : 0.0) // Set opacity based on tab selection
                                    .animation(.easeInOut)
                            } else if tabSelected == .cart {
                                MyCart(newOpenRecipes: openRecipes)
                                    .opacity(tabSelected == .cart ? 1.0 : 0.0) // Set opacity based on tab selection
                                    .animation(.easeInOut)
                            } else if tabSelected == .person {
                                Profile()
                                    .opacity(tabSelected == .person ? 1.0 : 0.0) // Set opacity based on tab selection
                                           .offset(x: tabSelected == .person ? 0 : -1000, y: 0) // Initial offset to the left
                                           .animation(.easeInOut)
                                    
                            }
                        }
                        .background(Color.clear)
                        .gesture(
                            DragGesture().onEnded { value in
                                if value.translation.width < -100 {
                                    switch tabSelected {
                                    case .refrigerator:
                                        tabSelected = .book
                                    case .book:
                                        tabSelected = .cart
                                    case .cart:
                                        tabSelected = .person
                                    case .person:
                                        break // The last tab, no further swipe action
                                    case .mic:
                                        tabSelected = .mic
                                    }
                                } else if value.translation.width > 100 {
                                    switch tabSelected {
                                    case .refrigerator:
                                        break // The first tab, no further swipe action
                                    case .book:
                                        tabSelected = .refrigerator
                                    case .cart:
                                        tabSelected = .book
                                    case .person:
                                        tabSelected = .cart
                                    case .mic:
                                        tabSelected = .mic
                                        
                                    }
                                }
                            }
                        )
                    }
                    VStack {
                        Spacer()
                        CustomTabBar(displaySpeakIngredients: displaySpeakIngredients, selectedTab: $tabSelected)
                    }
                }
                .navigationBarBackButtonHidden(true)
            } else {
                HStack() {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .frame(width: 50, height: 83)
                        .aspectRatio(contentMode: .fill)
                        .padding(.trailing, 8)
                        .shadow(radius: 3)
                    Text("EasyMeal")
                        .bold()
                        .foregroundColor(custGreen)
                        .font(.system(size: 45))
                    Spacer()
                }
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                isActive = true
            }
        }

    }
}
