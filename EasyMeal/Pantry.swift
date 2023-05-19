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
                
                
                    Button(action: {
                        groupedItems.loadData()
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 18))
                            Text("Reload Data")
                                .fontWeight(.regular)
                        }
                        .foregroundColor(.blue)
                    }
                    
                    
                    if (groupedItems.loading) {
                        VStack {
                            HStack(alignment: .center) {
                                ProgressView()
                            }
                            .padding(.top, 20)
                        }
                    }
                    
                    ForEach(groupedItems.groupedItems) { item in
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.subheadline)
                                .bold()
                            
                            
                            
                            FlexibleView(data: item.pantryIngredients, spacing: 5, alignment: .leading) { item in
                                GroupedItemButton(newSelectedItems: $groupedItems.selectedItems, newItem: item, newToggleItem: groupedItems.toggleItem)
                            }
                            
                            .padding(.horizontal, 5)
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 17)
                                .stroke(Color(hex: "#CCCCCC"), lineWidth: 1)
                                .foregroundColor(.white)
                                .padding(.horizontal, 1)
                        )
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
                .padding(.bottom, 200)
            }
            .offset(y: 10)
            .padding(.horizontal, 20)
            Spacer()
        }
        .background(Color(red: 240, green: 240, blue: 240))
        .fullScreenCover(isPresented: $speakIngredients) {
            SpeakIngredients(newCloseSpeakIngredients: closeSpeakIngredients)
        }
    }
    
}


