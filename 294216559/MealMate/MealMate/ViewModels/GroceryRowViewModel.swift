//
//  GroceryRowViewModel.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import Foundation
import CoreData

class GroceryRowViewModel: ObservableObject, Identifiable {
    @Published var grocery: Grocery
    private let viewContext: NSManagedObjectContext
    private let fridgeViewModel: FridgeViewModel
    
    var id: NSManagedObjectID {
        grocery.objectID
    }
    
    init(grocery: Grocery, viewContext: NSManagedObjectContext, fridgeViewModel: FridgeViewModel) {
        self.grocery = grocery
        self.viewContext = viewContext
        self.fridgeViewModel = fridgeViewModel
    }
    
    func toggleIsChecked() {
        grocery.isChecked.toggle()
        saveContext()
        if grocery.isChecked {
            fridgeViewModel.addToFridge(from: grocery)
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context after toggling isChecked: \(error)")
        }
    }
}
