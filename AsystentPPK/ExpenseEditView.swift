//
//  ExpenseEditView.swift
//  CarExpense
//
//  Created by student on 18/01/2024.
//

//import SwiftUI
//
//struct ExpenseEditView: View {
////    @Bindable var car: Car
//    var expense: Expense
//
//    var body: some View {
//        // Add your code for editing expense details here
//        Text("Edit Expense")
//    }
//}


import SwiftUI
import SwiftData

struct ExpenseEditView: View {
    @Bindable var expense: Expense

    var body: some View {
        Form {
            Section(header: Text("Expense Details")) {
                TextField("Type", text: $expense.type)
                    .textFieldStyle(.roundedBorder)

                DatePicker("Date", selection: $expense.date, displayedComponents: .date)

                HStack {
                    Text("Amount")
                    Spacer()
                    TextField("Amount", value: $expense.amount, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                }

                TextField("Comment", text: $expense.comment)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .navigationTitle("Edit Expense")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Preview
struct ExpenseEditView_Previews: PreviewProvider {
    static var previews: some View {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Expense.self, configurations: config)
            let exampleExpense = Expense(car: nil, type: "Fuel", date: Date(), amount: 50.0, comment: "Gas station")
            return ExpenseEditView(expense: exampleExpense).modelContainer(container)
        } catch {
            fatalError("Failed to create model container.")
        }
    }
}
