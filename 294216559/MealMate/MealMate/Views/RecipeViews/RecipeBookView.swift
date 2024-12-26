//
//  RecipeBookView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

struct RecipeBookView: View {
    // Sample data for demonstration
    @State private var recipes = [
        Recipe(id: 1, title: "Spaghetti Carbonara", imageName: "recipe1"),
        Recipe(id: 2, title: "Chicken Alfredo", imageName: "recipe2"),
        Recipe(id: 3, title: "Beef Stir Fry", imageName: "recipe3"),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeCardView(recipe: recipe)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("Recipe Book")
            .background(Color(.systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Add recipe action
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct RecipeCardView: View {
    let recipe: Recipe
    
    var body: some View {
        ZStack {
            Image(recipe.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .center
                    )
                )
                .cornerRadius(12)
                .shadow(radius: 5)
            
            VStack {
                Spacer()
                HStack {
                    Text(recipe.title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
            }
        }
    }
}

// Sample Recipe model
struct Recipe: Identifiable {
    let id: Int
    let title: String
    let imageName: String
}

// Placeholder for RecipeDetailView
struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        Text("\(recipe.title) recipe coming soon!")
            .navigationTitle(recipe.title)
    }
}
