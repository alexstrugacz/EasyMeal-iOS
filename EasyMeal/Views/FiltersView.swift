// FiltersView.swift
// EasyMeal
// Created by Pink Flamingo on 5/22/23.

import SwiftUI

// Filter view for recipes
struct FiltersView: View
{
    
    // State variables for filters and scores
    @Binding var showFilter: Bool
    @Binding var showHealth: Bool
    @Binding var showMinCal: Bool
    @Binding var showMaxCal: Bool
    @Binding var minHealthScore: Float
    @Binding var minCalories: Float
    @Binding var maxCalories: Float

    // Formatter for number display
    let numberFormatter: NumberFormatter =
    {
        let num = NumberFormatter()
        num.maximumFractionDigits = 0
        return num
    }()
    
    var body: some View
    {
        // Top bar with filter icon and recipe title
        ZStack
        {
            // Filter icon button
            HStack
            {
                Button(action: { showFilter.toggle() })
                {
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.gray)
                        .padding(.leading,10)
                }
                .padding(.leading, 10)

                Spacer()
            }
            // Recipe title
            HStack
            {
                Spacer()
                Text("Recipes")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                Spacer()
            }
        }
        .padding(.top, 25)

        // Filters
        if showFilter
        {
            // Horizontal stack for filter buttons
            HStack
            {
                // Health score filter button
                Button(action:
                {
                    showHealth.toggle()
                    if showHealth
                    {
                        showMaxCal = false
                        showMinCal = false
                    }
                })
                {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(custGreen)
                        .frame(height: 30)
                        .overlay(
                            Text("Health Score")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                        )
                }
                
                Spacer()
                
                // Min calorie filter button
                Button(action:
                {
                    showMinCal.toggle()
                    if showMinCal
                    {
                        showHealth = false
                        showMaxCal = false
                    }
                })
                {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(custMedGreen)
                        .frame(height: 30)
                        .overlay(
                            Text("Min Calories")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                        )
                }
                
                Spacer()
                
                // Max calorie filter button
                Button(action:
                {
                    showMaxCal.toggle()
                    if showMaxCal
                    {
                        showHealth = false
                        showMinCal = false
                    }
                })
                {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(custDarkGreen)
                        .frame(height: 30)
                        .overlay(
                            Text("Max Calories")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                        )
                }
            }
            .padding(.horizontal, 20)

            // Filter sliders
            VStack
            {
                // Health score slider
                if showHealth
                {
                    VStack
                    {
                        Text("Minimum Health Score:  \(numberFormatter.string(from: NSNumber(value: minHealthScore))!)")
                            .font(.system(size:20))
                        
                        Slider(value:$minHealthScore, in: 0...10, step: 1.0, minimumValueLabel: Text("0"), maximumValueLabel: Text("10"), label: {})
                            .padding(.horizontal,20)
                            .tint(custGreen)
                    }
                    .offset(y:-5)
                }
                
                // Min calorie slider
                if showMinCal
                {
                    VStack
                    {
                        Text("Minimum Calories:  \(numberFormatter.string(from: NSNumber(value: minCalories))!)")
                            .font(.system(size:20))
                        
                        Slider(value: $minCalories, in: 100...2000, step: 10.0, minimumValueLabel: Text("100"), maximumValueLabel: Text("2000"), label: {})
                            .padding(.horizontal,20)
                            .tint(custMedGreen)
                    }
                    .offset(y:-5)
                }
                
                // Max calorie slider
                if showMaxCal
                {
                    VStack
                    {
                        Text("Maximum Calories:  \(numberFormatter.string(from: NSNumber(value: maxCalories))!)")
                            .font(.system(size:20))
                        
                        Slider(value:$maxCalories, in: 100...2000, step: 10.0, minimumValueLabel: Text("100"), maximumValueLabel: Text("2000"), label: {})
                            .padding(.horizontal,20)
                            .tint(custDarkGreen)
                    }
                    .offset(y:-5)
                }
            }
            .padding(.top, 20)
        }
    }
}
