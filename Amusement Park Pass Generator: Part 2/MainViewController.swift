//
//  ViewController.swift
//  Amusement Park Pass Generator: Part 2
//
//  Created by Gary Luce on 17/08/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

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
    let fakePerson = Person(firstName: "John", lastName: "Doe", streetAddress: "10 Downing Street", city: "London", state: "England", zipCode: 5451, dateOfBirth: NSDate(), project: nil, company: nil)

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
                fourthSubEntrantType.setTitle(ContractEmployee.Contract.rawValue, forState: .Normal)
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
            case Employee.Food.rawValue, Employee.Ride.rawValue, Employee.Maintenance.rawValue, ContractEmployee.Contract.rawValue, Guest.Season.rawValue:
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
        zipcodeTextfield.delegate = self
        ssnTextfield.delegate = self
        projectNoTextfield.delegate = self
        firstNameTextField.delegate = self

        
    }
    override func viewWillAppear(animated: Bool) {
        self.pass = nil
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
                case Employee.Food.rawValue, Employee.Ride.rawValue, Employee.Maintenance.rawValue, ContractEmployee.Contract.rawValue, Guest.Season.rawValue, Manager.Manager.rawValue:
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

                    //Here we compare the child's date of birth against the current date
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yy"
                    if let dobString = dateOfBirthTextFields.text, let dob = dateFormatter.dateFromString(dobString) {
                     let yearsGap = NSDate().yearsFrom(dob)
                        if yearsGap > 5 {
                            print("The child is older than 5")
                            let alertController = UIAlertController(title: "The child cannot go in for free if older than 5", message: "Please select a Classic Pass", preferredStyle: UIAlertControllerStyle.Alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
                                print("OK")
                            }
                            alertController.addAction(okAction)
                            self.presentViewController(alertController, animated: true, completion: nil)

                        } else {
                            person = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: streetTextfield.text, city: cityTextfield.text, state: stateTextfield.text, zipCode: Int(zipcodeTextfield.text!), dateOfBirth: dob, project: nil, company: nil)
                            self.pass = PassGenerator(entrant: person!, entrantType: Guest.Child)
                        }
                    } else {
                        // Either the string cannot be converted to a date or there is no text in the textfield
                        let alertController = UIAlertController(title: "You have entered an invalid date", message: "Please use the specified format", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
                            print("OK")
                        }
                        alertController.addAction(okAction)
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                case Guest.Senior.rawValue:
                    person = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: streetTextfield.text, city: cityTextfield.text, state: stateTextfield.text, zipCode: Int(zipcodeTextfield.text!), dateOfBirth: NSDate(), project: nil, company: nil)
                    self.pass = PassGenerator(entrant: person!, entrantType: Guest.Senior)
                case Employee.Ride.rawValue:
                    person = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: streetTextfield.text, city: cityTextfield.text, state: stateTextfield.text, zipCode: Int(zipcodeTextfield.text!), dateOfBirth: NSDate(), project: nil, company: nil)
                    self.pass = PassGenerator(entrant: person!, entrantType: Employee.Ride)
                case Employee.Maintenance.rawValue:
                    person = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: streetTextfield.text, city: cityTextfield.text, state: stateTextfield.text, zipCode: Int(zipcodeTextfield.text!), dateOfBirth: NSDate(), project: nil, company: nil)
                    self.pass = PassGenerator(entrant: person!, entrantType: Employee.Maintenance)
                case ContractEmployee.Contract.rawValue:
                    person = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: streetTextfield.text, city: cityTextfield.text, state: stateTextfield.text, zipCode: Int(zipcodeTextfield.text!), dateOfBirth: NSDate(), project: Int(projectNoTextfield.text!), company: nil)
                    self.pass = PassGenerator(entrant: person!, entrantType: ContractEmployee.Contract)

                case Guest.Season.rawValue:
                    person = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: streetTextfield.text, city: cityTextfield.text, state: stateTextfield.text, zipCode: Int(zipcodeTextfield.text!), dateOfBirth: NSDate(), project: nil, company: nil)
                    self.pass = PassGenerator(entrant: person!, entrantType: Guest.Season)
                case Guest.VIP.rawValue:
                    person = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: streetTextfield.text, city: cityTextfield.text, state: stateTextfield.text, zipCode: Int(zipcodeTextfield.text!), dateOfBirth: NSDate(), project: nil, company: nil)
                    self.pass = PassGenerator(entrant: person!, entrantType: Guest.VIP)
                case Guest.Classic.rawValue:
                    person = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: streetTextfield.text, city: cityTextfield.text, state: stateTextfield.text, zipCode: Int(zipcodeTextfield.text!), dateOfBirth: NSDate(), project: nil, company: nil)
                    self.pass = PassGenerator(entrant: person!, entrantType: Guest.Classic)
                case Manager.Manager.rawValue:
                    person = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: streetTextfield.text, city: cityTextfield.text, state: stateTextfield.text, zipCode: Int(zipcodeTextfield.text!), dateOfBirth: NSDate(), project: nil, company: nil)
                    self.pass = PassGenerator(entrant: person!, entrantType: Manager.Manager)

                case Employee.Food.rawValue:
                    person = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: streetTextfield.text, city: cityTextfield.text, state: stateTextfield.text, zipCode: Int(zipcodeTextfield.text!), dateOfBirth: NSDate(), project: nil, company: nil)
                    self.pass = PassGenerator(entrant: person!, entrantType: Employee.Food)
                case Vendor.Vendor.rawValue:
                    person = Person(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: nil, city: nil, state: nil, zipCode: nil, dateOfBirth: NSDate(), project: nil, company: companyTextfield.text!)
                    self.pass = PassGenerator(entrant: person!, entrantType: Vendor.Vendor)
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
            print("prepare for segue called, passing \(self.pass?.entrant.firstName)")
            let vc = segue.destinationViewController as! PassViewController
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
    

    
    //MARK: Delegate methods
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //Note to reviewer: I have only implemented the zipcode. The instructions say I should impement a phone number but that is not specified anywhere else in the instructions or mockups so I am confused. The process would be the same anyway.
        let zipText = (zipcodeTextfield.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if let intText = Int(zipText) {
            print("The zip code is an int \(intText)")
        } else {
            let alertController = UIAlertController(title: "The Zip Code can only contain numbers", message: "Letters are not allowed in the zip code field", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
                print("OK")
            }
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            zipcodeTextfield.text = nil
        }
        
        //Max character count for first name:
        // Note to reviewer. The implementation is commented out as I have found no way to make the zipCode int check and this string length check work together within this delegate method. Both implemtations should work independently
//        let characterCount = firstNameTextField.text?.characters.count ?? 0
//        if (range.length + range.location > characterCount) {
//           return false
//        }
//        let newLength = characterCount + string.characters.count - range.length
//        return newLength <= 25
//        
        return true
    }

}

extension NSDate {
    func yearsFrom(date: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Year, fromDate: date, toDate: self, options: []).year
    }
}

