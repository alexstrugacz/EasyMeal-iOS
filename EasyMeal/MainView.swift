import SwiftUI

struct MainView<Content: View>: View {
    @State private var tabSelected: Tab = .refrigerator
    let destinationView: Content

    init(initialTab: Tab, @ViewBuilder content: () -> Content) {
        self.destinationView = content()
        self._tabSelected = State(initialValue: initialTab)
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                TabView(selection: $tabSelected) {
                    if tabSelected == .refrigerator {
                        Pantry()
                    } else if tabSelected == .cooktop {
                        Recipes()
                    } else if tabSelected == .cart {
                        MyCart()
                    } else if tabSelected == .person {
                        Profile()
                    }
                }
                .background(Color.clear)
            }
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $tabSelected)
            }
        }
        .navigationBarBackButtonHidden(true)

    }
    
}
