//
//  ExpenseItem.swift
//  iExpense
//
//  Created by OAA on 04/10/2022.
//

import Foundation

// Identifiable: Can be identified uniquely (no need for ForEach id), must have a property named id that is unique.
struct ExpenseItem: Identifiable, Codable {
    
    // UUID (Universally Unique Identifier: This is how we distinguish between expense items. They need to be unique, can't just be identifiable by name!
    // Not LET because swiftui has a warning for LET
    var id = UUID()
    
    let name: String
    let type: String
    let amount: Double
}


