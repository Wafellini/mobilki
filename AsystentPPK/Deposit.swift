//
//  Deposit.swift
//  AsystentPPK
//
//  Created by Bartlomiej Predki on 04/12/2023.
//

import Foundation
import SwiftData

enum Source: Int,Codable,CaseIterable {
    case employee = 1
    case employer = 2
    case government = 3
    case none = 0
    
    var asString: String {
        get {
            switch self {
            case .none:
                return ""
            case .employee:
                return "Pracownik"
            case .employer:
                return "Pracodawca"
            case .government:
                return "Państwo"
            }
        }
    }
}

@Model class Deposit {
    var source: Source
    var amount: Double
    var unitValue: Double
    var date: Date
    
    init(source: Source = .none, amount: Double, unitValue: Double, date: Date = Date()) {
        self.source = source
        self.amount = amount
        self.unitValue = unitValue
        self.date = date
    }
    
    var units: Double {
        get {
            let unitPrice = Double(truncating: self.unitValue as NSNumber)
            let amountValue = Double(truncating: self.amount as NSNumber)
            let un = amountValue / unitPrice
            return un
        }
    }
}


@Model class Car {
    @Attribute(.unique) var name: String
    var registrationNumber: String
    var VIN: String
    // Relacje z klasami podrzędnymi
    @Relationship(deleteRule: .cascade, inverse: \Fuel.car)
    var fuels: [Fuel]
    @Relationship(deleteRule: .cascade, inverse: \Expense.car)
    var expenses: [Expense]
    
    // Inne atrybuty i metody
    init(name: String, registrationNumber: String, VIN: String) {
        self.name = name
        self.registrationNumber = registrationNumber
        self.VIN = VIN
        self.fuels = []
        self.expenses = []
    }


}


@Model class Fuel {
    var car: Car?
    var date: Date
    var pricePerLiter: Double
    var mileage: Double
    var amountFueled: Double
    var totalCost: Double
    var location: String
    // Inne atrybuty i metody
init(car: Car?, date: Date, pricePerLiter: Double, mileage: Double, amountFueled: Double, totalCost: Double, location: String) {
    self.car = car
    self.date = date
    self.pricePerLiter = pricePerLiter
    self.mileage = mileage
    self.amountFueled = amountFueled
    self.totalCost = totalCost
    self.location = location
}


}
	
@Model class Expense {
    var car: Car?
    var type: String
    var date: Date
    var amount: Double
    var comment: String
    // Inne atrybuty i metody
init(car: Car?, type: String, date: Date, amount: Double, comment: String) {
    self.car = car
    self.type = type
    self.date = date
    self.amount = amount
    self.comment = comment
}


}





//class Account {
//    var name: String
//    var deposits: [Deposit]
//    var units: Double
//    var unitValue: Decimal
//}
