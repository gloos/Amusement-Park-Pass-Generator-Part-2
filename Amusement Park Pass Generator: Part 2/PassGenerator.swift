//
//  PassGenerator.swift
//  Amusement Park Pass Generator: Part 1
//
//  Created by Gary Luce on 08/08/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import Foundation

class PassGenerator {

    let entrant: Person
    let entrantType: String

    
    init(entrant: Person, entrantType: String) {
        self.entrant = entrant
        self.entrantType = entrantType
    }
    
    
  
    
    func verifyDataIntegrity() throws {
        switch self.entrantType {
        case Guest.Child.rawValue:
            guard self.entrant.dateOfBirth != nil else {
                throw DataIntegrity.MissingDateOfBirth
            }
        case Guest.Classic.rawValue, Guest.VIP.rawValue:
            print("We don't need information")
        case is Employee:
            guard self.entrant.firstName != nil else {
                throw DataIntegrity.MissingFirstName
            }
            guard self.entrant.lastName != nil else {
                throw DataIntegrity.MissingLastName
            }
            guard self.entrant.streetAddress != nil else {
                throw DataIntegrity.MissingAddress
            }
            guard self.entrant.state != nil else {
                throw DataIntegrity.MissingAddress
            }
            guard self.entrant.city != nil else {
                throw DataIntegrity.MissingCity
            }
            guard self.entrant.zipCode != nil else {
                throw DataIntegrity.MissingZipCode
            }
        default:
            print("Default called")
        }
    }
    
    func printEntrant() {
        print(entrant, entrantType)
    }
    


    
}