//
//  EditDepositView.swift
//  AsystentPPK
//
//  Created by Bartlomiej Predki on 04/12/2023.
//

import SwiftUI
import SwiftData

struct EditDepositView: View {
    
    @Bindable var deposit: Deposit
    
    var body: some View {
        Form {
            Section("Dane") {
                DatePicker("Data", selection: $deposit.date, displayedComponents: .date)
                HStack {
                    Text("Kwota wpłaty")
                    Spacer()
                    ClearableTextField("Kwota",value: $deposit.amount).frame(width: 100)
//                    TextField("Kwota", value: $deposit.amount, format:
//                            .number).textFieldStyle(.roundedBorder).frame(width: 100).multilineTextAlignment(.trailing).keyboardType(.decimalPad)
                    Text(" zł")
                }
                HStack {
                    Text("Wartość jednostki")
                    Spacer()
                    ClearableTextField("Wartość jednostki",value: $deposit.unitValue).frame(width: 100)
//                    TextField("Wartość jednostki", value: $deposit.unitValue).textFieldStyle(.roundedBorder).frame(width: 100).multilineTextAlignment(.trailing).keyboardType(.decimalPad)
                    Text(" zł")
                }
            }
            
            Section("Źródło") {
                Picker("Źródło", selection: $deposit.source) {
                    Text("Pracownik").tag(Source.employee)
                    Text("Pracodawca").tag(Source.employer)
                    Text("Państwo").tag(Source.government)
                }
                .pickerStyle(.segmented)
            }
        }
        .navigationTitle("Wpłata")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Deposit.self, configurations: config)

        let example = Deposit(amount: 123.45, unitValue: 44.55)
            return EditDepositView(deposit: example)
                .modelContainer(container)
        } catch {
            fatalError("Failed to create model container.")
        }
}
