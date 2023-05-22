//
//  SpeakerView.swift
//  EasyMeal
//
//  Created by Pink Flamingo on 5/21/23.
//

import SwiftUI

let numberOfSamples: Int = 10

struct SpeakerView: View {
    @ObservedObject private var mic = MicrophoneMonitor(numberOfSamples: numberOfSamples)
    
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
        
        return CGFloat(level * (300 / 25)) // scaled to max at 300 (our height of our bar)
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                ForEach(mic.soundSamples, id: \.self) { level in
                    BarView(value: self.normalizeSoundLevel(level: level))
                }
            }
        }
    
    }
}

struct BarView: View {
    var value: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(hex: "#F2F2F2"))
                .frame(width: ((UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 4) / CGFloat(numberOfSamples))-5, height: value)
        }
    }
}
