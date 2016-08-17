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

extension AreaAccess {
    func determineAcessArea(project: Int?, company: String?) -> AreaAccessType {
        if project != nil {
            switch project! {
            case 1001:
                return AreaAccessType(amusementArea: true, kitchenArea: false, rideControl: true, maintenanceArea: false, officeArea: false)
            case 1002:
                return AreaAccessType(amusementArea: true, kitchenArea: false, rideControl: true, maintenanceArea: true, officeArea: false)
                //TODO: Finish this
            default:
                <#code#>
            }
        } else if company != nil {
            print(company)
        }
    }
}


enum EntrantTypes: String {
    case Guest, Employee, Manager, Vendor
}


enum Guest: String, Entrant {
    case Classic, VIP, Child, Season, Senior
    func areasAccess() -> AreaAccessType {
        return AreaAccessType(amusementArea: true, kitchenArea: false, rideControl: false, maintenanceArea: false, officeArea: false)
    }
    
    func rideAccess() -> RideAccessType {
        switch self {
        case .Classic, .Child:
            return RideAccessType(all: true, skipAll: false)
        case .VIP, .Season, .Senior:
            return RideAccessType(all: true, skipAll: true)
        }
        
    }
    func discountAccess() -> DiscountAccessType {
        switch self {
        case .Classic, .Child:
            return DiscountAccessType(foodDiscount: nil, merchandiseDiscount: nil)
        case .VIP, .Season, .Senior:
            return DiscountAccessType(foodDiscount: 10, merchandiseDiscount: 20)
        }
    }
    
}

// I assume that all these people are employees
enum Employee: String, Entrant {
    case Food, Ride, Maintenance, Manager, Contract
    func areasAccess() -> AreaAccessType {
    switch self {
    case .Food, Ride, .Contract:
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
        break
        }
    }
    
    func discountAccess() -> DiscountAccessType {
        switch self {
        case .Food, .Ride, .Maintenance:
            return DiscountAccessType(foodDiscount: 15, merchandiseDiscount: 25)
        case .Manager:
            return DiscountAccessType(foodDiscount: 25, merchandiseDiscount: 25)
        case .Contract:
            return DiscountAccessType(foodDiscount: 0, merchandiseDiscount: 0)
        }
    }

}


