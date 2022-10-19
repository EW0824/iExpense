//
//  Expenses.swift
//  iExpense
//
//  Created by OAA on 04/10/2022.
//

import Foundation

// @StateObject only works with types conforming to ObservableObject
class Expenses: ObservableObject{
    
    // @Published announces changes from a property
    @Published var items = [ExpenseItem]() {
        // when the property is set
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
                
            }
        }
    }
    
    init() {
        
        // Try reading data from userDefaults
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            // If we can read that, try decoding it
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        // if above didn't work
        items = []
        
    }
    
    
    
    
    
    
}
