//
//  LoginViewController.swift
//  AboutMeUp (HW 2.6)
//
//  Created by Самир Джафари on 07.10.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    private var user: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTF.delegate = self
        passwordTF.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let login = loginTF.text, let password = passwordTF.text else {
            return false
        }
        
        do {
            user = try UserDataService.login(for: login, password: password)
            return true
        } catch UserDataServiceError.userNotFound(let title, let message) {
            showAlert(title: title, text: message)
            passwordTF.text = ""
            
            return false
        } catch {
            showAlert(
                title: "Неизвестная ошибка",
                text: "Произошла неизвестная ошибка. Попробуйте снова."
            )
            passwordTF.text = ""
            
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBarController = segue.destination as? UITabBarController else {
            return
        }
        
        guard let viewControllers = tabBarController.viewControllers else {
            return
        }
        
        for viewController in viewControllers {
            switch viewController {
            case let welcomeVC as WelcomeViewController:
                welcomeVC.user = user
            case let navigationVC as UINavigationController:
                guard let userInfoVC = navigationVC.topViewController as? UserInfoViewController else {
                    return
                }
                userInfoVC.user = user
            default: break
            }
        }
        
    }
    
    @IBAction func forgorButtonTapped(_ sender: UIButton) {
        sender.tag == ButtonTags.forgotLogin.rawValue
        ? showAlert(title: "Логин", text: "Логин для входа: \"samir\"")
        : showAlert(title: "Пароль", text: "Пароль для входа: \"samir\"")
    }
    
    @IBAction func unwind(for unwind: UIStoryboardSegue) {
        loginTF.text = ""
        passwordTF.text = ""
        
        user = nil
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTF:
            passwordTF.becomeFirstResponder()
            
        default: 
            textField.resignFirstResponder()
            if shouldPerformSegue(withIdentifier: "ToWelcomeVC", sender: nil) {
                performSegue(withIdentifier: "ToWelcomeVC", sender: nil)
            }
        }
        
        return true
    }
}

// MARK: - Alert

extension LoginViewController {
    private func showAlert(title: String, text: String) {
        let alertVC = UIAlertController(
            title: title,
            message: text,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "OK", style: .default)
        
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
}

// MARK: - Enums

extension LoginViewController {
    enum ButtonTags: Int {
        case forgotLogin
        case forgotPassword
    }
}
