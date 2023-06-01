//  SpeakerView.swift
//  EasyMeal
//  Created by Pink Flamingo on 5/21/23

import SwiftUI

// Number of samples
let numberOfSamples: Int = 10

// Speaker view
struct SpeakerView: View
{
    // Microphone monitor
    @ObservedObject private var mic = MicrophoneMonitor(numberOfSamples: numberOfSamples)

    // Sound level normalization function
    private func normalizeSoundLevel(level: Float) -> CGFloat
    {
        let level = max(0.2, CGFloat(level) + 50) / 2 // Normalize between 0.1 and 25
        return CGFloat(level * (300 / 25)) // Scale to max at 300 (height of bar)
    }

    // View body
    var body: some View
    {
        VStack
        {
            HStack(spacing: 4)
            {
                // Display bars for each sound sample
                ForEach(mic.soundSamples, id: \.self) { level in
                    BarView(value: self.normalizeSoundLevel(level: level))
                }
            }
        }
    }
}

// Bar view
struct BarView: View
{
    // Value for bar
    var value: CGFloat

    // View body
    var body: some View
    {
        ZStack
        {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(hex: "#F2F2F2"))
                .frame(width: ((UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 4) / CGFloat(numberOfSamples))-5, height: value)
        }
    }
}
