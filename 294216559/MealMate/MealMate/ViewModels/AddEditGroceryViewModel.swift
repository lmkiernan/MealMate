//
//  AddEditGroceryViewModel.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import Foundation
import CoreData

class AddEditGroceryViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var quantity: String = "1"
    @Published var unit: String = "unit"
    @Published var expirationDate: Date = Date()
    @Published var hasExpirationDate = false
    
    private let viewContext: NSManagedObjectContext
    private var grocery: Grocery?
    
    var isEditing: Bool {
        grocery != nil
    }
    
    init(context: NSManagedObjectContext, grocery: Grocery? = nil) {
        self.viewContext = context
        self.grocery = grocery
        if let grocery = grocery {
            name = grocery.name ?? ""
            quantity = String(grocery.quantity)
            unit = grocery.unit ?? "unit"
            hasExpirationDate = grocery.expirationDate != nil
            expirationDate = grocery.expirationDate ?? Date()
        }
    }
    
    func save() {
        guard let quantityDouble = Double(quantity) else { return }
        
        if let grocery = grocery {
            // Editing existing grocery
            grocery.name = name
            grocery.quantity = quantityDouble
            grocery.unit = unit
            grocery.expirationDate = hasExpirationDate ? expirationDate : nil
        } else {
            // Creating new grocery
            let newGrocery = Grocery(context: viewContext)
            newGrocery.id = UUID()
            newGrocery.name = name
            newGrocery.quantity = quantityDouble
            newGrocery.unit = unit
            newGrocery.expirationDate = hasExpirationDate ? expirationDate : nil
            newGrocery.isChecked = false // Set default value
        }
        
        do {
            try viewContext.save()
            print("Grocery item saved successfully.")
        } catch {
            print("Error saving grocery: \(error.localizedDescription)")
        }
    }
}
