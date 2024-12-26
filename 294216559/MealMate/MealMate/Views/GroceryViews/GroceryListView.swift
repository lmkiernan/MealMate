//
//  GroceryListView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI
import CoreData

struct GroceryListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: GroceryListViewModel
    @StateObject private var fridgeViewModel: FridgeViewModel

    @State private var showingAddSheet = false
    @State private var selectedGrocery: Grocery?

    init() {
        let context = PersistenceController.shared.container.viewContext
        _viewModel = StateObject(wrappedValue: GroceryListViewModel(viewContext: context))
        _fridgeViewModel = StateObject(wrappedValue: FridgeViewModel(context: context))
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.groceries) { grocery in
                    let rowViewModel = GroceryRowViewModel(grocery: grocery, viewContext: viewContext, fridgeViewModel: fridgeViewModel)
                    GroceryRowView(viewModel: rowViewModel)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedGrocery = grocery
                        }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Grocery List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddEditGroceryView(context: viewContext)
            }
            .sheet(item: $selectedGrocery) { grocery in
                AddEditGroceryView(context: viewContext, grocery: grocery)
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { viewModel.groceries[$0] }.forEach { grocery in
                viewModel.deleteGrocery(grocery)
            }
        }
    }
}
