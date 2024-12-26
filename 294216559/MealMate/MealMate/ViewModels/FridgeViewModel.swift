//
//  FridgeViewModel.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import Foundation
import CoreData
import Combine

class FridgeViewModel: ObservableObject {
    @Published var ingredients: [Ingredient] = []
    private let viewContext: NSManagedObjectContext
    private var cancellables = Set<AnyCancellable>()
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchIngredients()
        
        // Observe context changes
        NotificationCenter.default.publisher(for: .NSManagedObjectContextObjectsDidChange, object: viewContext)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.fetchIngredients()
            }
            .store(in: &cancellables)
    }
    
    func fetchIngredients() {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)]
        do {
            ingredients = try viewContext.fetch(request)
        } catch {
            print("Error fetching ingredients: \(error)")
        }
    }
    
    func deleteIngredient(_ ingredient: Ingredient) {
        viewContext.delete(ingredient)
        saveContext()
    }
    
    func addToFridge(from grocery: Grocery) {
        let fetchRequest: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", grocery.name ?? "")
        
        do {
            let existingIngredients = try viewContext.fetch(fetchRequest)
            
            if let existingIngredient = existingIngredients.first {
                // Update existing ingredient quantity
                existingIngredient.quantity += grocery.quantity
            } else {
                // Create new ingredient
                let ingredient = Ingredient(context: viewContext)
                ingredient.id = UUID()
                ingredient.name = grocery.name
                ingredient.quantity = grocery.quantity
                ingredient.unit = grocery.unit
                ingredient.expirationDate = grocery.expirationDate
            }
            
            saveContext()
        } catch {
            print("Error checking for existing ingredients: \(error)")
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
