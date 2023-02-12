import SwiftUI

struct MainView: View {
    @State private var tabSelected: Tab = .refrigerator
    
    init() {
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
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}
