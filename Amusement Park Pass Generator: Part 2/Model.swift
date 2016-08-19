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
            case 1003:
                return AreaAccessType(amusementArea: true, kitchenArea: true, rideControl: true, maintenanceArea: true, officeArea: true)
            case 2001:
                return AreaAccessType(amusementArea: false, kitchenArea: false, rideControl: false, maintenanceArea: false, officeArea: true)
            case 2002:
                return AreaAccessType(amusementArea: false, kitchenArea: true, rideControl: false, maintenanceArea: true, officeArea: false)
            default:
                return AreaAccessType(amusementArea: false, kitchenArea: false, rideControl: false, maintenanceArea: false, officeArea: false)

            }
        } else if company != nil {
            switch company! {
                case "Acme":
                    return AreaAccessType(amusementArea: false, kitchenArea: true, rideControl: false, maintenanceArea: false, officeArea: false)
                case "Orkin":
                    return AreaAccessType(amusementArea: true, kitchenArea: true, rideControl: true, maintenanceArea: false, officeArea: false)
                case "Fedex":
                    return AreaAccessType(amusementArea: false, kitchenArea: false, rideControl: false, maintenanceArea: true, officeArea: true)
                case "NW Electrical":
                    return AreaAccessType(amusementArea: true, kitchenArea: true, rideControl: true, maintenanceArea: true, officeArea: true)
            default:
                return AreaAccessType(amusementArea: false, kitchenArea: false, rideControl: false, maintenanceArea: false, officeArea: false)
            }
        } else {
            return AreaAccessType(amusementArea: false, kitchenArea: false, rideControl: false, maintenanceArea: false, officeArea: false)
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


enum Employee: String, Entrant {
    case Food, Ride, Maintenance
    func areasAccess() -> AreaAccessType {
    switch self {
    case .Food, Ride:
        return AreaAccessType(amusementArea: true, kitchenArea: false, rideControl: true, maintenanceArea: false, officeArea: false)
    case .Maintenance:
        return AreaAccessType(amusementArea: true, kitchenArea: true, rideControl: true, maintenanceArea: true, officeArea: false)

    
        }
    
    }
    
    func rideAccess() -> RideAccessType {
        switch self {
        case .Food, .Ride, .Maintenance:
            return RideAccessType(all: true, skipAll: true)

        }
    }
    
    func discountAccess() -> DiscountAccessType {
        switch self {
        case .Food, .Ride, .Maintenance:
            return DiscountAccessType(foodDiscount: 15, merchandiseDiscount: 25)
        }
    }

}
/* I have created the Vendor and Manager as an enums to be in line with other types of entrants which I think makes the code easier to read and more scalable if we add more types of Vendors in the future, however, switch statements wouldn't be needed it here since there's just one value*/

enum ContractEmployee: String, Entrant {
    case Contract
    func areasAccess() -> AreaAccessType {
        switch self {
        case  .Contract:
            return AreaAccessType(amusementArea: true, kitchenArea: false, rideControl: true, maintenanceArea: false, officeArea: false)
        }
        
    }
    
    func rideAccess() -> RideAccessType {
        switch self {
        case .Contract:
            return RideAccessType(all: false, skipAll: false)
        }
    }
    
    func discountAccess() -> DiscountAccessType {
        switch self {
        case .Contract:
            return DiscountAccessType(foodDiscount: 0, merchandiseDiscount: 0)
        }
    }
    
}
enum Vendor: String, Entrant {
    case Vendor
    func areasAccess() -> AreaAccessType {
        switch self {
        case .Vendor:
            return AreaAccessType(amusementArea: true, kitchenArea: true, rideControl: false, maintenanceArea: false, officeArea: false)
            
        }
        
    }
    
    func rideAccess() -> RideAccessType {
        switch self {
        case .Vendor:
            return RideAccessType(all: false, skipAll: false)
        }
    }
    
    func discountAccess() -> DiscountAccessType {
        switch self {
        case .Vendor:
            return DiscountAccessType(foodDiscount: 0, merchandiseDiscount: 0)
        }
    }
    
}

enum Manager: String, Entrant {
    case Manager
    func areasAccess() -> AreaAccessType {
        switch self {
            case .Manager:
                return AreaAccessType(amusementArea: true, kitchenArea: true, rideControl: true, maintenanceArea: true, officeArea: true)
        }
    }
    
    func rideAccess() -> RideAccessType {
        switch self {
        case  .Manager:
            return RideAccessType(all: true, skipAll: true)
        }
        
    }
    func discountAccess() -> DiscountAccessType {
        switch self {
        case .Manager:
            return DiscountAccessType(foodDiscount: 25, merchandiseDiscount: 25)
        }
    }
    
}

