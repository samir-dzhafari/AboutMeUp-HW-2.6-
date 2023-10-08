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
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
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
            return false
        } catch {
            showAlert(
                title: "Неизвестная ошибка",
                text: "Произошла неизвестная ошибка. Попробуйте снова."
            )
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let accountVC = segue.destination as? WelcomeViewController else {
            return
        }
        
        accountVC.modalPresentationStyle = .fullScreen
        accountVC.modalTransitionStyle = .flipHorizontal
        
        accountVC.user = user
    }
    
    @IBAction func forgorButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case ButtonTags.forgotLogin.rawValue:
            showAlert(title: "Логин", text: "Логин для входа: \"admin\"")
        case ButtonTags.forgotPassword.rawValue:
            showAlert(title: "Пароль", text: "Пароль для входа: \"admin\"")
        default: break
        }
    }
    
    @IBAction func unwind(for unwind: UIStoryboardSegue) {
        guard let _ = unwind.source as? WelcomeViewController else {
            return
        }
        
        clearData()
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

// MARK: - UI edit methods

extension LoginViewController {
    private func clearData() {
        loginTF.text = ""
        passwordTF.text = ""
        
        user = nil
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
