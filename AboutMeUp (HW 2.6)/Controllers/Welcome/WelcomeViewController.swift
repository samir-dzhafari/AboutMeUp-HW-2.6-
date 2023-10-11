//
//  WelcomeViewController.swift
//  AboutMeUp (HW 2.6)
//
//  Created by Самир Джафари on 07.10.2023.
//

import UIKit

final class WelcomeViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHelloLabel()
    }

}

//MARK: Setup methods

extension WelcomeViewController {
    private func setupView() {
        let color1 = UIColor(red: 218/255, green: 64/255, blue: 122/255, alpha: 1).cgColor
        let color2 = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupHelloLabel() {
        helloLabel.text = "Привет, \(user.login)!"
    }
}
