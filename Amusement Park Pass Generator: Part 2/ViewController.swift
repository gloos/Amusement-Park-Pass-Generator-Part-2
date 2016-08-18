//
//  ViewController.swift
//  Amusement Park Pass Generator: Part 2
//
//  Created by Gary Luce on 17/08/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var vendorDateOfVisit = NSDate()
    @IBOutlet weak var firstEntrantType: UIButton!
    @IBOutlet weak var secondEntrantType: UIButton!
    @IBOutlet weak var thirdEntrantType: UIButton!
    @IBOutlet weak var fourthEntrantType: UIButton!
    @IBOutlet weak var firstSubEntrantType: UIButton!
    @IBOutlet weak var secondSubEntrantType: UIButton!
    @IBOutlet weak var thirdSubEntrantType: UIButton!
    @IBOutlet weak var fourthSubEntrantType: UIButton!
    @IBOutlet weak var fifthSubEntrantType: UIButton!

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

    @IBAction func entrantButtonTapped(sender: UIButton) {
        disableForm()
        if let title = sender.currentTitle {
            switch title {
            case EntrantTypes.Guest.rawValue:
                showAllSubEntrantTypeButtons()
                firstSubEntrantType.setTitle(Guest.Classic.rawValue, forState: .Normal)
                secondSubEntrantType.setTitle(Guest.VIP.rawValue, forState: .Normal)
                thirdSubEntrantType.setTitle(Guest.Child.rawValue, forState: .Normal)
                fourthSubEntrantType.setTitle(Guest.Season.rawValue, forState: .Normal)
                fifthSubEntrantType.setTitle(Guest.Senior.rawValue, forState: .Normal)
            case EntrantTypes.Employee.rawValue:
                showAllSubEntrantTypeButtons()
                firstSubEntrantType.setTitle(Employee.Food.rawValue, forState: .Normal)
                secondSubEntrantType.setTitle(Employee.Maintenance.rawValue, forState: .Normal)
                thirdSubEntrantType.setTitle(Employee.Ride.rawValue, forState: .Normal)
                fourthSubEntrantType.setTitle(Employee.Contract.rawValue, forState: .Normal)
                fifthSubEntrantType.hidden = true
            case EntrantTypes.Manager.rawValue:
                hideAllSubEntrantTypeButtons()
                enableAddressTextfields()
            case Vendor.Vendor.rawValue:
                firstNameTextField.userInteractionEnabled = true
                firstNameTextField.backgroundColor = UIColor.whiteColor()
                lastNameTextField.userInteractionEnabled = true
                lastNameTextField.backgroundColor = UIColor.whiteColor()
                dateOfBirthTextFields.userInteractionEnabled = true
                dateOfBirthTextFields.backgroundColor = UIColor.whiteColor()
            default:
                print("We ran out of cases")
                
            }
        }
    }
    @IBAction func subEntrantButtonTapped(sender: UIButton) {
        disableForm()
        if let title = sender.currentTitle {
            switch title {
            case Guest.Child.rawValue:
                dateOfBirthTextFields.userInteractionEnabled = true
                dateOfBirthTextFields.backgroundColor = UIColor.whiteColor()
            case Guest.Senior.rawValue:
                firstNameTextField.userInteractionEnabled = true
                firstNameTextField.backgroundColor = UIColor.whiteColor()
                lastNameTextField.userInteractionEnabled = true
                lastNameTextField.backgroundColor = UIColor.whiteColor()
                dateOfBirthTextFields.userInteractionEnabled = true
                dateOfBirthTextFields.backgroundColor = UIColor.whiteColor()
            case Employee.Food.rawValue, Employee.Ride.rawValue, Employee.Maintenance.rawValue, Employee.Contract.rawValue, Guest.Season.rawValue:
                enableAddressTextfields()

            default:
                print("No information required")
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonTitles()
        disableForm()
    }


    
    //MARK: Helper methods
    
    func setButtonTitles() {
        firstEntrantType.setTitle(EntrantTypes.Guest.rawValue, forState: .Normal)
        secondEntrantType.setTitle(EntrantTypes.Employee.rawValue, forState: .Normal)
        thirdEntrantType.setTitle(EntrantTypes.Manager.rawValue, forState: .Normal)
        fourthEntrantType.setTitle(EntrantTypes.Vendor.rawValue, forState: .Normal)
        
    }
    func hideAllSubEntrantTypeButtons() {
        firstSubEntrantType.hidden = true
        secondSubEntrantType.hidden = true
        thirdSubEntrantType.hidden = true
        fourthSubEntrantType.hidden = true
        fifthSubEntrantType.hidden = true
    }
    
    func showAllSubEntrantTypeButtons() {
        firstSubEntrantType.hidden = false
        secondSubEntrantType.hidden = false
        thirdSubEntrantType.hidden = false
        fourthSubEntrantType.hidden = false
        fifthSubEntrantType.hidden = false
    }
    
    func disableForm() {
        dateOfBirthTextFields.userInteractionEnabled = false
        dateOfBirthTextFields.backgroundColor = UIColor.grayColor()
        ssnTextfield.userInteractionEnabled = false
        ssnTextfield.backgroundColor = UIColor.grayColor()
        projectNoTextfield.userInteractionEnabled = false
        projectNoTextfield.backgroundColor = UIColor.grayColor()
        firstNameTextField.userInteractionEnabled = false
        firstNameTextField.backgroundColor = UIColor.grayColor()
        lastNameTextField.userInteractionEnabled = false
        lastNameTextField.backgroundColor = UIColor.grayColor()
        companyTextfield.userInteractionEnabled = false
        companyTextfield.backgroundColor = UIColor.grayColor()
        streetTextfield.userInteractionEnabled = false
        streetTextfield.backgroundColor = UIColor.grayColor()
        cityTextfield.userInteractionEnabled = false
        cityTextfield.backgroundColor = UIColor.grayColor()
        stateTextfield.userInteractionEnabled = false
        stateTextfield.backgroundColor = UIColor.grayColor()
        zipcodeTextfield.userInteractionEnabled = false
        zipcodeTextfield.backgroundColor = UIColor.grayColor()
    }
    
    func enableAddressTextfields() {
        firstNameTextField.userInteractionEnabled = true
        firstNameTextField.backgroundColor = UIColor.whiteColor()
        lastNameTextField.userInteractionEnabled = true
        lastNameTextField.backgroundColor = UIColor.whiteColor()
        streetTextfield.userInteractionEnabled = true
        streetTextfield.backgroundColor = UIColor.whiteColor()
        cityTextfield.userInteractionEnabled = true
        cityTextfield.backgroundColor = UIColor.whiteColor()
        stateTextfield.userInteractionEnabled = true
        stateTextfield.backgroundColor = UIColor.whiteColor()
        zipcodeTextfield.userInteractionEnabled = true
        zipcodeTextfield.backgroundColor = UIColor.whiteColor()
    }
}

