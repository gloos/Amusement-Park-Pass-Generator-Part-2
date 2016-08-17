//
//  ErrorTypes.swift
//  Amusement Park Pass Generator: Part 1
//
//  Created by Gary Luce on 08/08/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import Foundation

enum DataIntegrity: ErrorType {
    case MissingDateOfBirth, MissingFirstName, MissingLastName, MissingAddress, MissingCity, MissingState, MissingZipCode
}