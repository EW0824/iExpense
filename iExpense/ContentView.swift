//
//  ContentView.swift
//  iExpense
//
//  Created by OAA on 23/09/2022.
//

import SwiftUI


/* Struct: everytime a property changes the whole struct is reconstructed.
 Class: only the property is changed.
 
 Hence @State only works with structs. We can use: @StateObject, @ObservedObject, @EnvironmentObject for classes.
 
 */

class User: ObservableObject {
    
    // publish announcement when properties change
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"

}

struct SecondView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let name: String
    
    var body: some View {
        Button("Dismiss"){
            dismiss()
        }
    }
}


struct ArchivableUser: Codable {
    let firstName: String
    let lastName: String
}


struct ExpenseOf: View {
    
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(item.name)
                    .font((item.amount > 50) ? .headline : .body)
                
                Text(item.type)
                    .italic()
            }
            
            Spacer()
            
            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                .font((item.amount > 500) ? .headline: .body)
            
        }
    }
}



struct ContentView: View {
    
    // Watch any change announcements -> refresh when any of the @Published changes
    // only for creating class instance.
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    
    
    var body: some View {
        
        NavigationView{
            
            List {
                
                // Personal Expenses
                Section {
                    ForEach(expenses.items) { item in
                        
                        if item.type == "Personal" {
                            
                            ExpenseOf(item: item)
                        }
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Personal Expenses")
                }
                
                // Business Expenses
                Section {
                    ForEach(expenses.items) { item in
                        
                        if item.type == "Business" {
                            
                            ExpenseOf(item: item)
                            
                        }
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Business Expenses")
                }
                
                
            // end bracket of List
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
                
            }
        // end bracket of Navigation view
        }
        
    }
    
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
