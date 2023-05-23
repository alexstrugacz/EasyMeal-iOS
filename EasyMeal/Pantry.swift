import SwiftUI

struct Pantry: View {
    @State private var searchText = ""
    @State private var loading = false
    @Binding var speakIngredients: Bool
    @StateObject var speechRecognizer = SpeechRecognizer()
    @ObservedObject var groupedItems: PantryViewModel = PantryViewModel()
    
    var displaySpeakIngredients: () -> Void
    
    let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    
    func closeSpeakIngredients() {
        speakIngredients = false
        groupedItems.loadData()
    }
    
    var body: some View {
        VStack{
            
            ScrollView(showsIndicators: false) {
                VStack(alignment:.leading) {
                    

                    VStack(alignment: .leading) {
                        Text("My Pantry")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding([.top], 20)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        Button(action: {
                            displaySpeakIngredients()
                        }) {
                            HStack {
                                Image(systemName: "mic.fill")
                                    .font(.system(size: 18))
                                Text("Speak Ingredients")
                                    .fontWeight(.bold
                                    )
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                            .background(LinearGradient(gradient: Gradient(colors: [custGreen, custGreen]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                        }
                        
                        
                        if (!groupedItems.loading) {
                            Button(action: {
                                groupedItems.resetData()
                            }) {
                                HStack {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 18))
                                    Text("Reset Pantry")
                                        .fontWeight(.regular)
                                }
                                .foregroundColor(.red)
                            }
                            .padding(.top, 20)
                        }
                    }
                    .padding(.horizontal, 5)
                
//                    Button(action: {
//                        groupedItems.loadData()
//                    }) {
//                        HStack {
//                            Image(systemName: "arrow.clockwise")
//                                .font(.system(size: 18))
//                            Text("Reload Data")
//                                .fontWeight(.regular)
//                        }
//                        .foregroundColor(.blue)
//                    }
                    
                    
//                    if (groupedItems.loading) {
//                        VStack {
//                            Spacer()
//                            HStack(alignment: .center) {
//                                Spacer()
//                                ProgressView()
//                                Spacer()
//                            }
//                            .padding(.top, 20)
//                            Spacer()
//                        }
//                    }
//                    
                    ForEach(groupedItems.groupedItems) { item in
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.subheadline)
                                .bold()
                            FlexibleView(data: item.pantryIngredients, spacing: 5, alignment: .leading) { item in
                                GroupedItemButton(newSelectedItems: $groupedItems.selectedItems, newItem: item, newToggleItem: groupedItems.toggleItem)
                            }
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 25)
                        .background(
                            RoundedRectangle(cornerRadius: 17)
                                .foregroundColor(.white)
                                .padding(.horizontal, 1)
                                .shadow(color: Color(hex: "#d4d4d4"), radius: 5,x: 0, y: 2)
                                .padding(5)
                        )
                    }
                }
                .padding(.bottom, 200)
            }
            .offset(y: 10)
            .padding(.horizontal, 15)
            Spacer()
        }
        .background(Color(hex: "#F7F7F7"))
        .refreshable {
            
            groupedItems.loadData()
        }
        .fullScreenCover(isPresented: $speakIngredients) {
            SpeakIngredients(newCloseSpeakIngredients: closeSpeakIngredients)
        }
        .onAppear {
            UIScrollView.appearance().isPagingEnabled = false
        }

    }
    
}


