//
//  AddView.swift
//  iExpense
//
//  Created by OAA on 08/10/2022.
//

import SwiftUI

struct AddView: View {
    
    // Not creating it -> passed from ContentView!
    // @ObservedObject: watches an observed object for changes
    @ObservedObject var expenses: Expenses
    
    // Type not necessary
    @Environment(\.dismiss) var dismiss
    
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]
    
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
                    
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}



// Showing the view on the right (not important)

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        // Dummy value works
        AddView(expenses: Expenses())
    }
}
