//
//  PassViewController.swift
//  Amusement Park Pass Generator: Part 2
//
//  Created by Gary Luce on 18/08/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import UIKit

class PassViewController : UIViewController {
    
    var generatedPass : PassGenerator?
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var passType: UILabel!
    
    @IBOutlet weak var ridesLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var secondDiscountLabel: UILabel!
    
    override func viewDidLoad() {
        if let name = generatedPass?.entrant.firstName {
            print(name)
        }
        if self.generatedPass != nil {
            print("generatedPass exists")
            fullName.text = "\(generatedPass!.entrant.firstName!) \(generatedPass?.entrant.lastName!)"
        }
    }
}
