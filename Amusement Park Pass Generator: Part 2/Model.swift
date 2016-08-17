//
//  Model.swift
//  Amusement Park Pass Generator: Part 1
//
//  Created by Gary Luce on 08/08/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import Foundation

protocol AreaAccess {
    func areasAccess() -> AreaAccessType
}

protocol RideAccess {
    func rideAccess() -> RideAccessType
}

protocol DiscountAccess {
    func discountAccess() -> DiscountAccessType
}

protocol Entrant: AreaAccess, RideAccess, DiscountAccess {
    
}

protocol FullyNamed {
    var firstName: String? { get }
    var lastName: String? { get }
    var streetAddress: String? { get }
    var city: String? { get }
    var state: String? { get }
    var zipCode: Int? { get }
    var dateOfBirth: NSDate? { get }
}

struct AreaAccessType {
    var amusementArea: Bool
    var kitchenArea: Bool
    var rideControl: Bool
    var maintenanceArea: Bool
    var officeArea: Bool
}

struct RideAccessType {
    var all: Bool
    var skipAll: Bool
}

struct DiscountAccessType {
    var foodDiscount: Int?
    var merchandiseDiscount: Int?
}

struct Person: FullyNamed {
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipCode: Int?
    var dateOfBirth: NSDate?

}

enum EntrantTypes: String {
    case Guest, Employee, Manager, Vendor
}


enum Guest: String, Entrant {
    case Classic, VIP, Child
    func areasAccess() -> AreaAccessType {
        return AreaAccessType(amusementArea: true, kitchenArea: false, rideControl: false, maintenanceArea: false, officeArea: false)
    }
    
    func rideAccess() -> RideAccessType {
        switch self {
        case .Classic, .Child:
            return RideAccessType(all: true, skipAll: false)
        case .VIP:
            return RideAccessType(all: true, skipAll: true)
        }
        
    }
    func discountAccess() -> DiscountAccessType {
        switch self {
        case .Classic, .Child:
            return DiscountAccessType(foodDiscount: nil, merchandiseDiscount: nil)
        case .VIP:
            return DiscountAccessType(foodDiscount: 10, merchandiseDiscount: 20)
        }
    }
    
}

enum Employee: Entrant {
    case Food, Ride, Maintenance, Manager
    func areasAccess() -> AreaAccessType {
    switch self {
    case .Food, Ride:
        return AreaAccessType(amusementArea: true, kitchenArea: false, rideControl: true, maintenanceArea: false, officeArea: false)
    
    case .Maintenance:
        return AreaAccessType(amusementArea: true, kitchenArea: true, rideControl: true, maintenanceArea: true, officeArea: false)
    case .Manager:
        return AreaAccessType(amusementArea: true, kitchenArea: true, rideControl: true, maintenanceArea: true, officeArea: true)
    
        }
    
    }
    
    func rideAccess() -> RideAccessType {
        switch self {
        case .Food, .Ride, .Maintenance, .Manager:
            return RideAccessType(all: true, skipAll: true)
        }
    }
    
    func discountAccess() -> DiscountAccessType {
        switch self {
        case .Food, .Ride, .Maintenance:
            return DiscountAccessType(foodDiscount: 15, merchandiseDiscount: 25)
        case .Manager:
            return DiscountAccessType(foodDiscount: 25, merchandiseDiscount: 25)
        }
    }

}

