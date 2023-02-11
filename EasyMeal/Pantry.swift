//
//  Pantry.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 2/10/23.
//

import SwiftUI

struct Pantry: View {
    @State var selection = false

    var body: some View {
            VStack {
                Text("Pantry")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)

            }
    }
}

