import SwiftUI

struct CustomTabBar: View {
    
    var displaySpeakIngredients: () -> Void
    
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    private var tabColor: Color {
        switch selectedTab {
        case .refrigerator:
            return .white
        case .cooktop:
            return .white
        case .cart:
            return .white
        case .person:
            return .white
        case .mic:
            return custTabBarGreen
        }
    }
    
    var body: some View {
        ZStack {
            HStack {
                //make make mic just the green color to hide it instead
                ForEach(Tab.allCases.filter { tab in
                    // only show mic icon when selected tab is .refrigerator
                    return tab == .mic && selectedTab != .refrigerator ? false : true
                }, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .foregroundColor(tab == selectedTab ? tabColor : .white)
                        .font(.system(size: 20))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.075)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
                
            }
            .frame(width: nil, height: 65)
            .background(custTabBarGreen)
            .cornerRadius(50)
            .padding()
            
            if selectedTab == .refrigerator {
                let micImage = Image(systemName: "mic")
                    .font(.system(size: 30))
                    //.foregroundColor(custMicGreen)
                    .foregroundColor(.white)

                
                Circle()
                    .fill(custMicGreen)
                    .frame(width: 77, height: 77)
                
                    .overlay(
                        Circle()
                            //.fill(Color.white)
                            .fill(custMicGreen)
                            .frame(width: 74, height: 74)
                            .overlay(
                                Button(action: {
                                    displaySpeakIngredients()
                                }) {
                                    micImage
                                }
                            )
                            .shadow(color: .black.opacity(0.4), radius: 6, x: 0, y: 0)
                    )
                Spacer()
                
            }
            
        }
    }
}
