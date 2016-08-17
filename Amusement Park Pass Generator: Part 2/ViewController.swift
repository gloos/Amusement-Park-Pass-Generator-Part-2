//
//  ViewController.swift
//  Amusement Park Pass Generator: Part 2
//
//  Created by Gary Luce on 17/08/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var firstEntrantType: UIButton!
    @IBOutlet weak var secondEntrantType: UIButton!
    @IBOutlet weak var thirdEntrantType: UIButton!
    @IBOutlet weak var fourthEntrantType: UIButton!
    @IBOutlet weak var firstSubEntrantType: UIButton!
    @IBOutlet weak var secondSubEntrantType: UIButton!

    @IBOutlet weak var dateOfBirthTextFields: UITextField!
    @IBOutlet weak var ssnTextfield: UITextField!
    @IBOutlet weak var projectNoTextfield: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyTextfield: UITextField!
    @IBOutlet weak var streetTextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var stateTextfield: UITextField!
    @IBOutlet weak var zipcodeTextfield: UITextField!
    @IBAction func firstEntrantTypeButtonTapped(sender: AnyObject) {
        
        firstSubEntrantType.setTitle(Guest.Child.rawValue, forState: .Normal)
    }
    @IBAction func entrantButtonTapped(sender: UIButton) {
        if let title = sender.currentTitle {
            switch title {
            case EntrantTypes.Guest.rawValue:
                firstSubEntrantType.setTitle(Guest.Classic.rawValue, forState: .Normal)
                secondSubEntrantType.setTitle(Guest.VIP.rawValue, forState: .Normal)
            case EntrantTypes.Employee.rawValue:
                firstSubEntrantType.setTitle(Employee.Food.rawValue, forState: .Normal)
                secondSubEntrantType.setTitle(Employee.Maintenance.rawValue, forState: .Normal)
            default:
                print("We ran out of cases")
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonTitles()
    }


    
    //MARK: Helper methods
    
    func setButtonTitles() {
        firstEntrantType.setTitle(EntrantTypes.Guest.rawValue, forState: .Normal)
        secondEntrantType.setTitle(EntrantTypes.Employee.rawValue, forState: .Normal)
        thirdEntrantType.setTitle(EntrantTypes.Manager.rawValue, forState: .Normal)
        fourthEntrantType.setTitle(EntrantTypes.Vendor.rawValue, forState: .Normal)
        
    }
}

