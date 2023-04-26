import SwiftUI

enum Tab: String, CaseIterable {
    case refrigerator
    case cooktop
    case mic
    case cart
    case person
}

struct CustomTabBar: View {
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
            return .white
        }
    }
    
    @State private var isPressed = false
    
    var body: some View {
        ZStack {
            HStack {
                //make make mic just the green color to hide it instead
                ForEach(Tab.allCases.filter { $0 != .mic }, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .foregroundColor(tab == selectedTab ? tabColor : .white)
                        .font(.system(size: 20))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
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
                    .foregroundColor(.white)
                
                Circle()
                    .strokeBorder(custMicGreen, lineWidth: 2)
                    .frame(width: 74, height: 74)
                
                    .overlay(
                        Circle()
                            .fill(custMicGreen)
                            .frame(width: 74, height: 74)
                            .overlay(
                                Button(action: {
                                    isPressed.toggle()
                                }) {
                                    micImage
                                }
                            )
                            .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 0)
                    )
                Spacer()
                
            }
            
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.refrigerator))
    }
}


