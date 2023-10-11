//
//  HobbiesViewController.swift
//  AboutMeUp (HW 2.6)
//
//  Created by Самир Джафари on 11.10.2023.
//

import UIKit

class UserHobbiesViewController: UIViewController {

    
    @IBOutlet weak var hobbiesLabel: UILabel!
    
    var hobbies: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hobbiesLabel.text = hobbies.joined(separator: "\n")
    }

}
