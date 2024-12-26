//
//  MyFridgeView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

struct MyFridgeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: FridgeViewModel

    @State private var showingAddSheet = false
    @State private var selectedIngredient: Ingredient?
    @State private var showingIngredientList = false

    init() {
        _viewModel = StateObject(wrappedValue: FridgeViewModel(context: PersistenceController.shared.container.viewContext))
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.ingredients.isEmpty {
                    EmptyStateView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                            ForEach(viewModel.ingredients) { ingredient in
                                FridgeItemView(ingredient: ingredient)
                                    .onTapGesture {
                                        selectedIngredient = ingredient
                                    }
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            viewModel.deleteIngredient(ingredient)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("My Fridge")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingIngredientList = true }) {
                        Image(systemName: "list.bullet")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddEditIngredientView(context: viewContext)
            }
            .sheet(item: $selectedIngredient) { ingredient in
                AddEditIngredientView(context: viewContext, ingredient: ingredient)
            }
            .sheet(isPresented: $showingIngredientList) {
                NavigationView {
                    List {
                        ForEach(viewModel.ingredients) { ingredient in
                            IngredientRowView(ingredient: ingredient)
                                .onTapGesture {
                                    selectedIngredient = ingredient
                                    showingIngredientList = false
                                }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let ingredient = viewModel.ingredients[index]
                                viewModel.deleteIngredient(ingredient)
                            }
                        }
                    }
                    .navigationTitle("Ingredients List")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                showingIngredientList = false
                            }
                        }
                    }
                }
            }
        }
    }
}
