//
//  AddEditIngredientView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI
import CoreData

struct AddEditIngredientView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: AddEditIngredientViewModel
    @StateObject private var foodSearch = FoodSearchService()
    @State private var searchText: String = ""

    init(context: NSManagedObjectContext, ingredient: Ingredient? = nil) {
        _viewModel = StateObject(wrappedValue: AddEditIngredientViewModel(context: context, ingredient: ingredient))
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Search section
                    if !viewModel.isEditing {
                        VStack(spacing: 16) {
                            CustomSearchBar(text: $searchText, placeholder: "Search USDA Food Database")

                            if foodSearch.isLoading {
                                ProgressView()
                                    .progressViewStyle(.circular)
                            } else if !foodSearch.searchResults.isEmpty {
                                VStack(alignment: .leading, spacing: 2) {
                                    ForEach(foodSearch.searchResults) { food in
                                        Button(action: {
                                            viewModel.name = food.displayName
                                            searchText = ""
                                        }) {
                                            Text(food.displayName)
                                                .foregroundColor(.primary)
                                                .padding(.vertical, 8)
                                                .padding(.horizontal, 12)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .background(Color(.systemBackground))

                                        if food.id != foodSearch.searchResults.last?.id {
                                            Divider()
                                        }
                                    }
                                }
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }
                        }
                    }

                    // Name field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        CustomTextField(placeholder: "Enter ingredient name", text: $viewModel.name, icon: "pencil")
                    }

                    // Quantity field
                    CustomQuantityField(quantity: $viewModel.quantity, unit: $viewModel.unit)

                    // Expiration date section
                    VStack(alignment: .leading, spacing: 8) {
                        Toggle(isOn: $viewModel.hasExpirationDate) {
                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.gray)
                                    .frame(width: 24)
                                Text("Expiration Date")
                            }
                        }
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                        if viewModel.hasExpirationDate {
                            CustomDatePicker(date: $viewModel.expirationDate)
                                .transition(.opacity)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(viewModel.isEditing ? "Edit Ingredient" : "Add Ingredient")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.save()
                        dismiss()
                    }
                    .disabled(viewModel.name.isEmpty || viewModel.quantity.isEmpty)
                }
            }
            .onChange(of: searchText) {
                Task {
                    await foodSearch.searchFoods(searchText)
                }
            }
        }
    }
}
