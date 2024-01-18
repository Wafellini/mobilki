//
//  ContentView.swift
//  AsystentPPK
//
//  Created by Bartlomiej Predki on 06/11/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Deposit.date, order: .reverse) var deposits: [Deposit]
    @Query() var cars: [Car]
    
    @State private var path = [Car]()
    @State private var sumOfUnits = 0.0
    @State private var showUnitEditor = false
    
    @AppStorage("unitValue") private var unitValue = 1.0
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
//                List {
//                    ForEach(deposits) { deposit in
//                        NavigationLink(value: deposit) {
//                            VStack(alignment: .leading) {
//                                HStack {
//                                    Text(deposit.date.formatted(date: .abbreviated,time: .omitted))
//                                    Spacer()
//                                    Text(deposit.source.asString).font(.caption)
//                                }
//                                HStack {
//                                    Text("\(deposit.amount.formatted()) zł")
//                                    Spacer()
//                                    Text("@\(deposit.unitValue.formatted()) zł")
//                                    Spacer()
//                                    Text("\(deposit.units.format(decimalPlaces: 4)) ju.")
//                                }
//                            }
//                        }.navigationDestination(for: Deposit.self, destination: EditDepositView.init)
//                    }.onDelete(perform: deleteDeposits)
//                }
//                .navigationTitle("Wpłaty").toolbar {
//                    Button("Odśwież",systemImage: "command.square.fill", action: sumUnits)
//                    Button("Dodaj wpłatę", systemImage: "plus", action: addDeposits)
//                }
                
                List {
                    ForEach(cars) { car in
                        NavigationLink(car.name, destination: ExpenseListView(car: car))
                    }.onDelete(perform: deleteCar)
                }.toolbar {
                    Button(action: addCar) {
                        Label("Dodaj samochód", systemImage: "plus")
                    }
                }


            }
            HStack {
                Text("W sumie jednostek: ")
                Spacer()
                Text("\(sumOfUnits.format(decimalPlaces: 4)) ju.").onAppear {
                    sumUnits()
                }
            }.padding(5)
            HStack {
                Text("Wartość jednostek: ")
                Spacer()
                Text("\((sumOfUnits*unitValue).format(decimalPlaces: 2)) zł")
            }.padding(5)
            if !showUnitEditor {
                HStack(alignment: .center) {
                    Button("Edytuj") {
                        showUnitEditor = true
                    }
                }
            }
            if showUnitEditor {
                VStack {
                    Text("Wartość jednostki rozliczeniowej")
                    HStack {
                        ClearableTextField("Wartość jednostki", value: $unitValue).fixedSize().frame(width: 150)
                        Spacer()
                        Button("Zapisz") {
                            showUnitEditor = false
                        }
                    }
                }
            }
        }
        .padding()
        
    }
    
    func addDeposits() {
        let deposit = Deposit(amount: 0.00, unitValue: unitValue)
        modelContext.insert(deposit)
//        path = [deposit]
    }
    
    func deleteDeposits(_ indexSet: IndexSet) {
        for index in indexSet {
            let depositsToDelete = deposits[index]
            modelContext.delete(depositsToDelete)
        }
        sumUnits()
    }
    
    func addCar() {
        let newCar = Car(name: "", registrationNumber: "", VIN: "")
        // Możesz otworzyć EditCarView z nowym obiektem Car
        // Możesz też dodać logikę do zapisania nowego samochodu w bazie danych
        modelContext.insert(newCar)
//        path = [newCar]
    }
    
    func deleteCar(_ indexSet: IndexSet) {
        for index in indexSet {
            let carToDelete = cars[index]
            modelContext.delete(carToDelete)
        }
    }

    
    func sumUnits() {
        var sum: Double = 0
        for d in deposits {
            sum += d.units
        }
       sumOfUnits = sum
    }
    
}

#Preview {
    ContentView()
}
