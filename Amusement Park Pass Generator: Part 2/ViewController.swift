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
    var selectedSubEntrant: UIButton?
    var pass: PassGenerator?
    let fakePerson = Person(firstName: "John", lastName: "Doe", streetAddress: "10 Downing Street", city: "London", state: "England", zipCode: 5451, dateOfBirth: NSDate())

    @IBAction func entrantButtonTapped(sender: UIButton) {
        resetForm()
        disableForm()
        self.selectedSubEntrant = nil
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
                self.selectedSubEntrant = sender
                hideAllSubEntrantTypeButtons()
                enableAddressTextfields()
            case Vendor.Vendor.rawValue:
                hideAllSubEntrantTypeButtons()
                self.selectedSubEntrant = sender
                firstNameTextField.userInteractionEnabled = true
                firstNameTextField.backgroundColor = UIColor.whiteColor()
                lastNameTextField.userInteractionEnabled = true
                lastNameTextField.backgroundColor = UIColor.whiteColor()
                companyTextfield.userInteractionEnabled = true
                companyTextfield.backgroundColor = UIColor.whiteColor()
                dateOfBirthTextFields.userInteractionEnabled = true
                dateOfBirthTextFields.backgroundColor = UIColor.whiteColor()
            default:
                print("We ran out of cases")
                
            }
        }
    }
    @IBAction func subEntrantButtonTapped(sender: UIButton) {
        resetForm()
        disableForm()
        self.selectedSubEntrant = sender
        print(self.selectedSubEntrant)
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
        hideAllSubEntrantTypeButtons()
        disableForm()
        
    }

    @IBAction func populateData(sender: AnyObject) {
        resetForm()
        if self.selectedSubEntrant != nil {
            if let title = self.selectedSubEntrant?.currentTitle {
                switch title {
                case Guest.Child.rawValue:
                    dateOfBirthTextFields.text = String(fakePerson.dateOfBirth)
                case Guest.Senior.rawValue:
                    firstNameTextField.text = fakePerson.firstName
                    lastNameTextField.text = fakePerson.lastName
                    dateOfBirthTextFields.text = String(fakePerson.dateOfBirth)
                case Employee.Food.rawValue, Employee.Ride.rawValue, Employee.Maintenance.rawValue, Employee.Contract.rawValue, Guest.Season.rawValue, Manager.Manager.rawValue:
                    firstNameTextField.text = fakePerson.firstName
                    lastNameTextField.text = fakePerson.lastName
                    streetTextfield.text = fakePerson.streetAddress
                    cityTextfield.text = fakePerson.city
                    stateTextfield.text = fakePerson.state
                    zipcodeTextfield.text = String(fakePerson.zipCode)
                case Vendor.Vendor.rawValue:
                    firstNameTextField.text = fakePerson.firstName
                    lastNameTextField.text = fakePerson.lastName
                    dateOfBirthTextFields.text = String(fakePerson.dateOfBirth)
                default:
                    print("Cannot populate the data")
                }
            }
        } else {
            let alertController = UIAlertController(title: "Select a Sub Entrant Type", message: "Please select a sub entrant type (e.g Child, Senior, etc.)", preferredStyle: UIAlertControllerStyle.Alert)

            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
                print("OK")
            }
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    @IBAction func generatePass(sender: UIButton) {
        if selectedSubEntrant == nil {
            let alertController = UIAlertController(title: "Select a Sub Entrant Type", message: "Please select a sub entrant type (e.g Child, Senior, etc.)", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
                print("OK")
            }
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)

        } else {
            print("We are about to create a pass")
            if let title = self.selectedSubEntrant?.currentTitle {
                var person: Person?
                switch title {
                case Guest.Child.rawValue:
                    person = Person(firstName: nil, lastName: nil, streetAddress: nil, city: nil, state: nil, zipCode: nil, dateOfBirth: NSDate())
                    self.pass = PassGenerator(entrant: person!, entrantType: title)
                case Guest.Senior.rawValue:
                    person = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: nil, city: nil, state: nil, zipCode: nil, dateOfBirth: NSDate())
                    self.pass = PassGenerator(entrant: person!, entrantType: title)
                case Employee.Food.rawValue, Employee.Ride.rawValue, Employee.Maintenance.rawValue, Employee.Contract.rawValue, Guest.Season.rawValue, Manager.Manager.rawValue:
                    person = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: streetTextfield.text, city: cityTextfield.text, state: stateTextfield.text, zipCode: Int(zipcodeTextfield.text!), dateOfBirth: NSDate())
                    self.pass = PassGenerator(entrant: person!, entrantType: title)
                case Vendor.Vendor.rawValue:
                    person = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: nil, city: nil, state: nil, zipCode: nil, dateOfBirth: NSDate())
                    self.pass = PassGenerator(entrant: person!, entrantType: title)
                    firstNameTextField.text = fakePerson.firstName
                    lastNameTextField.text = fakePerson.lastName
                    dateOfBirthTextFields.text = String(fakePerson.dateOfBirth)
                default:
                    print("Cannot populate the data")
                }

            }

        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPass" {
            print("prepare for segue called, passing \(self.pass)")
            let vc = PassViewController()
            vc.generatedPass = self.pass
        }
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
    
    func resetForm() {
        dateOfBirthTextFields.text = nil
        ssnTextfield.text = nil
        projectNoTextfield.text = nil
        firstNameTextField.text = nil
        lastNameTextField.text = nil
        companyTextfield.text = nil
        streetTextfield.text = nil
        cityTextfield.text = nil
        stateTextfield.text = nil
        zipcodeTextfield.text = nil
    }
    
    func twoDaysAgo() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        return calendar.dateByAddingUnit(.Day, value: -2, toDate: NSDate(), options: [])!
    }
    
    func compareDates(date: NSDate) -> Bool {
        let today = NSDate()
        return NSCalendar.currentCalendar().isDate(today, equalToDate: date, toUnitGranularity: [.Day, .Month])
    }

}

