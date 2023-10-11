//
//  AboutMeViewController.swift
//  AboutMeUp (HW 2.6)
//
//  Created by Самир Джафари on 11.10.2023.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = "Имя: \(user.info.name)"
        surnameLabel.text = "Фамилия: \(user.info.surname)"
        ageLabel.text = "Возраст: \(user.info.age)"
        postLabel.text = "Должность: \(user.info.post)"
    }
    
    override func viewDidLayoutSubviews() {
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userImageView.image = user.info.image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userHobbiesVC = segue.destination as? UserHobbiesViewController else {
            return
        }
        
        userHobbiesVC.hobbies = user.hobbies
    }

}
