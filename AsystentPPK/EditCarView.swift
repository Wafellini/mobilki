//
//  EditCarView.swift
//  AsystentPPK
//
//  Created by student on 11/01/2024.
//

// EditCarView.swift
import SwiftUI
import SwiftData

struct EditCarView: View {
    @Bindable var car: Car

    var body: some View {
        Form {
            Section("Dane Samochodu") {
                TextField("Nazwa", text: $car.name)
                    .textFieldStyle(.roundedBorder)
                TextField("Numer rejestracyjny", text: $car.registrationNumber)
                    .textFieldStyle(.roundedBorder)
                TextField("Numer VIN", text: $car.VIN)
                    .textFieldStyle(.roundedBorder)
                // Add additional fields as necessary
            }
        }
        .navigationTitle("Edycja Samochodu")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Preview
struct EditCarView_Previews: PreviewProvider {
    static var previews: some View {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Car.self, configurations: config)
            let exampleCar = Car(name: "Example Car", registrationNumber: "XYZ 123", VIN: "1HGBH41JXMN109186")
            return EditCarView(car: exampleCar).modelContainer(container)
        } catch {
            fatalError("Failed to create model container.")
        }
    }
}
