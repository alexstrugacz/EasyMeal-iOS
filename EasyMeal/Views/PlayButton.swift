//
//  PlayButton.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/17/23.
//

import SwiftUI

struct PlayButton: View {
    @Binding var playing: Bool
    var startRecording: () -> Void
    var stopRecording: () -> Void
    
    var body: some View {
        
            Button {
                startRecording()
            } label: {
                ZStack {
                    Image(systemName: "play.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                }
                .frame(width: 150, height: 150)
                .background(custGreen)
                .cornerRadius(100)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 7, x: 2, y: 3)
            }
    }
}
