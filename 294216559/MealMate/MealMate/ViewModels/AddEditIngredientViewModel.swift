//
//  AddEditIngredientViewModel.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import Foundation
import CoreData

class AddEditIngredientViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var quantity: String = "1"
    @Published var unit: String = "unit"
    @Published var expirationDate: Date = Date()
    @Published var hasExpirationDate = false
    
    private let viewContext: NSManagedObjectContext
    private var ingredient: Ingredient?
    
    var isEditing: Bool {
        ingredient != nil
    }
    
    init(context: NSManagedObjectContext, ingredient: Ingredient? = nil) {
        self.viewContext = context
        self.ingredient = ingredient
        if let ingredient = ingredient {
            name = ingredient.name ?? ""
            quantity = String(ingredient.quantity)
            unit = ingredient.unit ?? "unit"
            hasExpirationDate = ingredient.expirationDate != nil
            expirationDate = ingredient.expirationDate ?? Date()
        }
    }
    
    func save() {
        guard let quantityDouble = Double(quantity) else { return }
        
        if let ingredient = ingredient {
            // Update existing ingredient
            ingredient.name = name
            ingredient.quantity = quantityDouble
            ingredient.unit = unit
            ingredient.expirationDate = hasExpirationDate ? expirationDate : nil
        } else {
            // Add new ingredient
            let newIngredient = Ingredient(context: viewContext)
            newIngredient.id = UUID()
            newIngredient.name = name
            newIngredient.quantity = quantityDouble
            newIngredient.unit = unit
            newIngredient.expirationDate = hasExpirationDate ? expirationDate : nil
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving ingredient: \(error)")
        }
    }
}
