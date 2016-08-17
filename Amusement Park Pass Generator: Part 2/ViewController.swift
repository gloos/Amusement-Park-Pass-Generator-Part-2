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

    @IBAction func firstEntrantTypeButtonTapped(sender: AnyObject) {
        
        firstSubEntrantType.setTitle(Guest.Child.rawValue, forState: .Normal)
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

