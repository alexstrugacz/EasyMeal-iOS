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
        tabSelected = .cooktop
    }

    
    var body: some View {
        
        ZStack {
            if (isActive) {
                ZStack {
                    VStack {
                        TabView(selection: $tabSelected) {
                            if tabSelected == .refrigerator {
                                Pantry(speakIngredients: $displayingSpeakIngredients, displaySpeakIngredients: displaySpeakIngredients)
                            } else if tabSelected == .cooktop {
                                Recipes(openCart: openCart)
                            } else if tabSelected == .cart {
                                MyCart(newOpenRecipes: openRecipes)
                            } else if tabSelected == .person {
                                Profile()
                            }
                        }
                        .background(Color.clear)
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
