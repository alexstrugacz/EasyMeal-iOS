//
//  FilterView.swift
//  EasyMeal
//
//  Created by Pink Flamingo on 5/22/23.
//

import SwiftUI

struct FilterView: View {
    @Binding var showView: Bool
    @Binding var showHealth: Bool
    @Binding var showMinCal: Bool
    @Binding var showMaxCal: Bool
    
    @Binding var minHealthScore: Float
    @Binding var minCalories: Float
    @Binding var maxCalories: Float
        
    let numberFormatter: NumberFormatter = {
        let num = NumberFormatter()
        num.maximumFractionDigits = 0
        return num
    }()
    
    var body: some View {
        HStack {
            Button(action: {
                if showHealth == true{
                    showHealth = false
                } else {
                    showHealth = true
                    showMaxCal = false
                    showMinCal = false
                }
                }
            ) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(custGreen)
                    .frame(width: 120, height: 30)
                    .overlay(
                        Text("Heath Score")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                    )
            }
            
            Spacer()
            
            Button(action: {
                if showMinCal == true{
                    showMinCal = false
                } else {
                    showHealth = false
                    showMaxCal = false
                    showMinCal = true
                }
                }
            ) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(custMedGreen)
                    .frame(width: 120, height: 30)
                    .overlay(
                        Text("Min Calories")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                    )
            }
            
            Spacer()
            
            
            Button(action: {
                if showHealth == true{
                    showMaxCal = false
                } else {
                    showHealth = false
                    showMaxCal = true
                    showMinCal = false
                }
                }
            ) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(custDarkGreen)
                    .frame(width: 120, height: 30)
                    .overlay(
                        Text("Max Calories")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                    )
            }
        }
        .offset (y: -13)
        .padding(.horizontal, 20)
        if showHealth {
            VStack{
                Text("Minimum Health Score:  \(numberFormatter.string(from: NSNumber(value: minHealthScore))!)")
                    .font(.system(size:20))
                
                Slider(value: $minHealthScore, in: 0...10, step: 1.0, minimumValueLabel: Text("0"), maximumValueLabel: Text("10"), label: {})
                    .padding(.horizontal,20)
                    .tint(custGreen)
            }
            .offset(y:-5)
        }
        
        if showMinCal {
            VStack{
                Text("Minimum Calories:  \(numberFormatter.string(from: NSNumber(value: minCalories))!)")
                    .font(.system(size:20))
                
                Slider(value: $minCalories, in: 100...2000, step: 10.0, minimumValueLabel: Text("100"), maximumValueLabel: Text("2000"), label: {})
                    .padding(.horizontal,20)
                    .tint(custMedGreen)
                    
            }
            .offset(y:-5)
        }
        
        if showMaxCal {
            VStack{
                Text("Maximum Calories:  \(numberFormatter.string(from: NSNumber(value: maxCalories))!)")
                    .font(.system(size:20))
                
                Slider(value: $maxCalories, in: 100...2000, step: 10.0, minimumValueLabel: Text("100"), maximumValueLabel: Text("2000"), label: {})
                    .padding(.horizontal,20)
                    .tint(custDarkGreen)
            }
            .offset(y:-5)
        }
    }
}
