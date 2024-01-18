//
//  AsystentPPKApp.swift
//  AsystentPPK
//
//  Created by Bartlomiej Predki on 06/11/2023.
//

import SwiftUI
import SwiftData

@main
struct AsystentPPKApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: [Deposit.self, Car.self])
    }
}
