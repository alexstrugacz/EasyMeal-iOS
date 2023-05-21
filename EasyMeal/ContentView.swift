import SwiftUI

struct ContentView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    var triggerNextPage: () -> Void
    
    init(triggerNextPage: @escaping () -> Void ) {
        self.triggerNextPage = triggerNextPage
        self.contentViewModel = ContentViewModel(triggerNextPage: triggerNextPage)
    }

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { scrollViewProxy in
                    HStack(spacing: 0) {
                        ForEach(0..<PAGES.count) { index in
                            VStack {
                                Text(PAGES[index].title)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding()
                                
                                Image(PAGES[index].imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                                
                                Text(PAGES[index].subtitle)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                            .frame(width: UIScreen.main.bounds.width)
                            .id(index)
                        }
                    }
//                    .offset(x: CGFloat(contentViewModel.currentPage) * -UIScreen.main.bounds.width, y: 0)
                    .onChange(of: contentViewModel.currentPage) { newValue in
                        scrollViewProxy.scrollTo(newValue, anchor: .center)

                        if newValue == PAGES.count - 1 {
                            print("transition")
                        }
                        
                    }
                    .onAppear {
                        UIScrollView.appearance().isPagingEnabled = true
                    }
                }
            }
            .gesture(
               DragGesture().onChanged { value in
                   print(value.translation.width)
                   if value.translation.width > 0 {
                       print("GO BACK")
                      contentViewModel.prevPage()
                  } else {
                      print("NEXT")
                      contentViewModel.nextPage()
                  }
               }
            )
            HStack {
                ForEach(0..<PAGES.count) { index in
                    Button {
                        contentViewModel.currentPage = index
                    } label: {
                        

                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(index == contentViewModel.currentPage ? Color.gray : Color.gray.opacity(0.5))
                            .shadow(color: index == contentViewModel.currentPage ? Color.black.opacity(0.3) : Color.clear, radius: 3, x: 0, y: 2)
                            .padding(.trailing, 4)
                            .id(index)
                    }
                        
                }
            }
            
            Button(action: {
                contentViewModel.nextPage()
            }) {
                Text("Continue")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.green) // set to custGreen
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
struct OffsetPreferenceKey: PreferenceKey {
    typealias Value = [OffsetPreferenceData]
    
    static var defaultValue: [OffsetPreferenceData] = []
    
    static func reduce(value: inout [OffsetPreferenceData], nextValue: () -> [OffsetPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

struct OffsetPreferenceData: Equatable {
    let rect: CGRect
}


