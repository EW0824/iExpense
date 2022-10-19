//
//  ContentView.swift
//  iExpense
//
//  Created by OAA on 23/09/2022.
//

import SwiftUI


/* Struct: everytime a property changes the whole struct is reconstructed.
 Class: only the property is changed.
 
 Hence @State only wor cks with structs. We can use: @StateObject, @ObservedObject, @EnvironmentObject.
 
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



struct ContentView: View {
    
    // Watch any change announcements -> refresh when any of the @Published changes
    // only for creating class instance.
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    
    
    var body: some View {
        
        NavigationView{
            
            List {
                ForEach(expenses.items) { item in
                    
                    if item.type == "Personal" {
                        
                        
                        HStack {
                            
                            VStack(alignment: .leading) {
                                
                                Text(item.name)
                                    .font((item.amount > 10) ? .headline : .system)
                                
                                Text(item.type)
                                    .italic()
                                                                
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                .font((item.amount > 100) ? .headline: .system)
                            
                        }
                        
                        
                        
//                        if item.amount < 10 {
//
//                            HStack{
//                                VStack(alignment: .leading){
//
//                                    Text(item.name)
//
//                                    Text(item.type)
//                                        .italic()
//
//                                }
//
//                                Spacer()
//
//                                Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
//                            }
//
//                        }
//
//                        else if item.amount < 100 {
//
//                            HStack{
//                                VStack(alignment: .leading){
//
//                                    Text(item.name)
//                                        .font(.headline)
//
//                                    Text(item.type)
//                                        .italic()
//
//                                }
//
//                                Spacer()
//
//                                Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
//                            }
//
//                        }
//
//                        else {
//                            HStack{
//                                VStack(alignment: .leading){
//
//                                    Text(item.name)
//                                        .font(.headline)
//
//                                    Text(item.type)
//                                        .italic()
//
//                                }
//
//                                Spacer()
//
//                                Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
//                                    .font(.headline)
//                            }
//
//                        }

                    }
                    
//                    else {
//
//                        Section {
//
//
//                            Text("Here lies the business expenses")
//
//
//
//                        } header: {
//                            Text("Business Expenses")
//                        }
//
//
//
//
//                    }
                    
                }
                .onDelete(perform: removeItems)
                
                
//                Section {
//
//                    ForEach(expenses.items) { item in
//
//                        if expenses.type == "Business" {
//
//                            if item.amount < 10 {
//
//                                HStack{
//                                    VStack(alignment: .leading){
//
//                                        Text(item.name)
//
//                                        Text(item.type)
//                                            .italic()
//
//                                    }
//
//                                    Spacer()
//
//                                    Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
//                                }
//
//                            }
//
//                            else if item.amount < 100 {
//
//                                HStack{
//                                    VStack(alignment: .leading){
//
//                                        Text(item.name)
//                                            .font(.headline)
//
//                                        Text(item.type)
//                                            .italic()
//
//                                    }
//
//                                    Spacer()
//
//                                    Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
//                                }
//
//                            }
//
//                            else {
//                                HStack{
//                                    VStack(alignment: .leading){
//
//                                        Text(item.name)
//                                            .font(.headline)
//
//                                        Text(item.type)
//                                            .italic()
//
//                                    }
//
//                                    Spacer()
//
//                                    Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
//                                        .font(.headline)
//                                }
//                            }
//                        }
//                    }
////                     .onDelete(perform: removeItems)
//
//                } header: {
//                        Text("Business Expenses")
//                }
                    
                    
                    
                
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
