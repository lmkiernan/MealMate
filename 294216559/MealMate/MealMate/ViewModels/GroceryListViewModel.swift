//
//  GroceryListViewModel.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import Foundation
import CoreData
import Combine

class GroceryListViewModel: ObservableObject {
    @Published var groceries: [Grocery] = []
    private let viewContext: NSManagedObjectContext
    private var cancellables = Set<AnyCancellable>()
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        fetchGroceries()
        
        // Observe context changes
        NotificationCenter.default.publisher(for: .NSManagedObjectContextObjectsDidChange, object: viewContext)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.fetchGroceries()
            }
            .store(in: &cancellables)
    }
    
    func fetchGroceries() {
        let request: NSFetchRequest<Grocery> = Grocery.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Grocery.name, ascending: true)]
        do {
            groceries = try viewContext.fetch(request)
        } catch {
            print("Error fetching groceries: \(error)")
        }
    }
    
    func deleteGrocery(_ grocery: Grocery) {
        viewContext.delete(grocery)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
