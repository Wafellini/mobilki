//
//  ExpenseListView.swift
//  CarExpense
//
//  Created by student on 18/01/2024.
//
import Foundation
import SwiftUI
import SwiftData

struct ExpenseListView: View {
    @Bindable var car: Car
    @Environment(\.modelContext) var modelContext
//    @Query(sort: \Deposit.date, order: .reverse) var deposits: [Deposit]
//    @Query() var cars: [Car]
//    var expenses: [Expense]
//    @EnvironmentObject var carData: CarData
    
    

    var body: some View {
        NavigationView {
            List{
                ForEach(car.expenses){
                    expense in
                    NavigationLink(destination: ExpenseEditView(expense: expense)) {
                        Text("Expense on \(expense.date)")
                    }
                }.onDelete(perform: deleteExpense)
            }
            .navigationTitle("Expenses").toolbar {
                Button(action: addExpense) {
                    Label("Dodaj wydatek", systemImage: "plus")
                }
            }
        }
    }
    func addExpense() {
        let newexpense = Expense(car: car, type: "", date: Date(), amount: 1, comment: "")
        // Możesz otworzyć EditCarView z nowym obiektem Car
        // Możesz też dodać logikę do zapisania nowego samochodu w bazie danych
        car.expenses.append(newexpense)
        modelContext.insert(newexpense)
//        path = [car]
    }
    
//    func deleteExpense(_ indexSet: IndexSet) {
//        for index in indexSet {
//            let expensesToDelete = car.expenses[index]
//            modelContext.delete(expensesToDelete)
//        }
//    }
    
    func deleteExpense(_ indexSet: IndexSet) {
        for index in indexSet {
            let expenseToDelete = car.expenses[index]
            car.expenses.remove(at: index)
            modelContext.delete(expenseToDelete)
            }
        }

}
