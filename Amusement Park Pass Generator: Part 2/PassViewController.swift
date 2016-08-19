//
//  PassViewController.swift
//  Amusement Park Pass Generator: Part 2
//
//  Created by Gary Luce on 18/08/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import UIKit

class PassViewController : UIViewController {
    
    var generatedPass: PassGenerator?
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var passType: UILabel!
    
    @IBOutlet weak var ridesLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var secondDiscountLabel: UILabel!
    @IBAction func createNewPass(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var discount: DiscountAccessType {
        if let pass = generatedPass?.entrantType {
            switch pass {
            case Guest.VIP.rawValue:
                return Guest.VIP.discountAccess()
            case Employee.Food.rawValue, Employee.Ride.rawValue, Employee.Maintenance.rawValue:
                return Employee.Food.discountAccess()
            case Manager.Manager.rawValue:
                return Manager.Manager.discountAccess()
            case Guest.Season.rawValue:
                return Guest.Season.discountAccess()
            case Guest.Senior.rawValue:
                return Guest.Senior.discountAccess()
            default:
                return Vendor.Vendor.discountAccess()
            }
        }
        return Manager.Manager.discountAccess()
    }
    
    var rides: String {
        if let pass = generatedPass?.entrantType {
            switch pass {
            case Guest.VIP.rawValue, Guest.Season.rawValue, Guest.Senior.rawValue:
                return "Unlimited rides access / Skip lines"
            case Guest.Classic.rawValue, Guest.Child.rawValue, Employee.Food.rawValue, Employee.Maintenance.rawValue, Employee.Ride.rawValue, Manager.Manager.rawValue:
                return "Unlimited rides access"
            default:
                return "Rides access denied"
            }
        }
        return "Rides access denied"
    }
    
    override func viewDidLoad() {
        print(generatedPass?.entrant.firstName)
        if self.generatedPass != nil, let firstName = generatedPass?.entrant.firstName, let lastName = generatedPass?.entrant.lastName, let pass = generatedPass?.entrantType {
            print("generatedPass exists")
            fullName.text = "\(firstName) \(lastName)"
            passType.text = pass
            self.discountLabel.text = "\(discount.foodDiscount!)% food discount"
            self.secondDiscountLabel.text = "\(discount.merchandiseDiscount!)% merchandise discount"
            ridesLabel.text = rides
        }
    }
    
}
