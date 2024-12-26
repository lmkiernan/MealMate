//
//  MealPlannerView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

struct MealPlannerView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(daysOfWeek, id: \.self) { day in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(day)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                                .padding(.top, 8)
                            
                            VStack(spacing: 0) {
                                mealRow(mealType: "Breakfast")
                                Divider()
                                mealRow(mealType: "Lunch")
                                Divider()
                                mealRow(mealType: "Dinner")
                            }
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .padding(.horizontal)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                        }
                        .padding(.bottom, 16)
                    }
                }
                .padding(.top)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Meal Planner")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Add meal action
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    // Helper method to create a meal row
    private func mealRow(mealType: String) -> some View {
        HStack {
            Image(systemName: iconName(for: mealType))
                .foregroundColor(.blue)
                .frame(width: 24)
            Text(mealType)
                .font(.headline)
            Spacer()
            Text("Add Meal")
                .foregroundColor(.secondary)
                .font(.subheadline)
        }
        .padding()
    }
    
    // Helper method to get icon name for meal type
    private func iconName(for mealType: String) -> String {
        switch mealType {
        case "Breakfast":
            return "sunrise.fill"
        case "Lunch":
            return "sun.max.fill"
        case "Dinner":
            return "moon.fill"
        default:
            return "questionmark"
        }
    }
    
    // Array of days of the week
    private let daysOfWeek = [
        "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
    ]
}
