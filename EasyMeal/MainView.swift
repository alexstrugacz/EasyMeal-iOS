import SwiftUI

struct MainView<Content: View>: View {
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
        tabSelected = .refrigerator
    }

    
    
    var body: some View {
        
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

    }
    
}
