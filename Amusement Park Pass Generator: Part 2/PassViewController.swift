//
//  PassViewController.swift
//  Amusement Park Pass Generator: Part 2
//
//  Created by Gary Luce on 18/08/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import UIKit
import AudioToolbox

class PassViewController : UIViewController {
    var sound: SystemSoundID = 0
    var generatedPass: PassGenerator?
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var passType: UILabel!
    
    @IBOutlet weak var testResultLabel: UILabel!
    @IBOutlet weak var ridesLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var secondDiscountLabel: UILabel!
    @IBAction func createNewPass(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var discount: DiscountAccessType {
        if let pass = generatedPass?.entrantType {
            return pass.discountAccess()
        } else {
            return DiscountAccessType(foodDiscount: 0, merchandiseDiscount: 0)
        }
    }
    
    
    var rides: String {
        if let pass = generatedPass?.entrantType {
            let access = pass.rideAccess()
            if access.all == true && access.skipAll == true {
                return "Can access all rides and skip all lines"
            } else if access.all == true {
                return "Can access all rides"
            } else if access.skipAll == true {
                return " Can skip all lines"
            } else {
                return "Cannot skip lines or access any ride"
            }
        } else {
            return "The pass was badly generated, please try again"
        }
    }
    
    //TODO: This doesn't work for a vendor or contract employee. FIX!
    var areaAccess: AreaAccessType {
        if let pass = generatedPass?.entrantType {
            return pass.areasAccess()
        } else if generatedPass?.entrantType  is Vendor {
            print("We have a vendor")
            return Vendor.Vendor.determineAcessArea(nil, company: generatedPass?.entrant.company)
        }
          else  {
            return AreaAccessType(amusementArea: false, kitchenArea: false, rideControl: false, maintenanceArea: false, officeArea: false)
        }
    }
    //Note to reviewer: Here I did not test access to other areas because the process would be the same and would clutter the code even more.
    @IBAction func kitchenAccessButtonTapped(sender: UIButton) {
        if self.areaAccess.kitchenArea == true {
            testResultLabel.backgroundColor = UIColor.greenColor()
            playGrantedAccessSound()
            testResultLabel.text = "Access Granted"
        } else {
            testResultLabel.backgroundColor = UIColor.redColor()
            playDeniedAccessSound()
            testResultLabel.text = "Access Denied!"
            
        }
    }
    @IBAction func skipLineButtonTapped(sender: UIButton) {
        if generatedPass?.entrantType.rideAccess().skipAll == true {
            testResultLabel.backgroundColor = UIColor.greenColor()
            playGrantedAccessSound()
            testResultLabel.text = "Access Granted"
        } else {
            testResultLabel.backgroundColor = UIColor.redColor()
            playDeniedAccessSound()
            testResultLabel.text = "Access Denied!"
            
        }
    }
    @IBAction func foodDiscountButtonTapped(sender: UIButton) {
        if let foodDiscount = self.discount.foodDiscount where foodDiscount != 0 {
            testResultLabel.backgroundColor = UIColor.greenColor()
            playGrantedAccessSound()
            testResultLabel.text = "The Entrant has \(foodDiscount) % off here!"
        } else {
            testResultLabel.backgroundColor = UIColor.redColor()
            playDeniedAccessSound()
            testResultLabel.text = "This Entrant has no discount here. :("
            
        }
    }
    override func viewDidLoad() {
        if self.generatedPass != nil, let firstName = generatedPass?.entrant.firstName, let lastName = generatedPass?.entrant.lastName, let pass = generatedPass?.entrantType {
            print("generatedPass exists \(pass)")
            fullName.text = "\(firstName) \(lastName)"
            print("The pass is \(pass)")
            passType.text = String(pass)
            if let foodDiscount = self.discount.foodDiscount where foodDiscount != 0 {
            self.discountLabel.text = "\(discount.foodDiscount!)% food discount"
            }
            if let merchandiseDiscount = self.discount.merchandiseDiscount where merchandiseDiscount != 0 {
                self.secondDiscountLabel.text = "\(discount.merchandiseDiscount!)% merchandise discount"
            }

            ridesLabel.text = self.rides
            
        }
    }

        
        //MARK: Helper methods
        
    func playGrantedAccessSound() {
        self.sound = 0
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("AccessGranted", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &self.sound)
        AudioServicesPlaySystemSound(self.sound)
        
    }
    
    func playDeniedAccessSound() {
        self.sound = 0
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("AccessDenied", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &self.sound)
        AudioServicesPlaySystemSound(self.sound)
        
    }

    
}
