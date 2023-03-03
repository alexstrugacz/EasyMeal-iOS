//
//  ContentView.swift
//  EasyMeal
//
//  Created by Alex Strugacz on 2/1/23.
//

import SwiftUI

let custGreen = Color(hex: "#0ACF83")
let custShadow = Color(hex: "9B9CA2")
let custGray = Color(hex: "FAF9F9")
let custLightRed = Color(hex: "FF8F8F")


struct MainPage: View {
    @State var showView = false
    @State var showView2 = false
    
    var body: some View {
        NavigationView{
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                
                
                Text("EasyMeal")
                    .bold()
                    .font(.system(size: 60))
                
                
                Button(action: {
                    print("toInfoOne")
                                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                                            self.showView = true
                                        }
                    
                }) {
                    Text("Get Started")
                        .foregroundColor(.white)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 16)
                        .background(LinearGradient(gradient: Gradient(colors: [custGreen, custGreen]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                        .shadow(color: custShadow, radius: 1, x: 1, y: 1)
                }
                .offset(y:50)
                NavigationLink(destination: InfoOne(), isActive: $showView) {
                                    EmptyView()
                                }
                
                
                
                HStack {
                    Text("Already a member?")
                        .font(.system(size: 20))
                    
                    Button(action: {
                        print("toSignIn")
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            self.showView2 = true
                        }
                    }) {
                        Text("Sign In")
                            .foregroundColor(.black)
                            .underline()
                    }
                    
                }
                .offset(y: 150)
                NavigationLink(destination: SignIn(), isActive: $showView2) {
                                    EmptyView()
                                }
                
            }
            .background(
                Image("waves3")
                    .offset(y: 230)
                    
            )
            
        }
        
    }
}






extension Color {
    init(hex string: String) {
        var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }

        // Double the last value if incomplete hex
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }

        // Fix invalid values
        if string.count > 8 {
            string = String(string.prefix(8))
        }

        // Scanner creation
        let scanner = Scanner(string: string)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        if string.count == 2 {
            let mask = 0xFF

            let g = Int(color) & mask

            let gray = Double(g) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)

        } else if string.count == 4 {
            let mask = 0x00FF

            let g = Int(color >> 8) & mask
            let a = Int(color) & mask

            let gray = Double(g) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)

        } else if string.count == 6 {
            let mask = 0x0000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)

        } else if string.count == 8 {
            let mask = 0x000000FF
            let r = Int(color >> 24) & mask
            let g = Int(color >> 16) & mask
            let b = Int(color >> 8) & mask
            let a = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)

        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        }
    }

}

