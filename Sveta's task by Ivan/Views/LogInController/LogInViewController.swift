//
//  LogInViewController.swift
//  Sveta's task by Ivan
//
//  Created by mac on 06.05.2022.
//

import UIKit

class LogInViewController: UIViewController {

        //MARK: - @IBoutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
        //MARK: - Properties
    let userName = "user"
    let password = "1234"
    
        //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
        //MARK: - @IBActions
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        
        guard !userNameTextField.text!.isEmpty || !passwordTextField.text!.isEmpty else {
            showAlertEnterAllFields()
            return
        }
        
        guard userName == userNameTextField.text && password == passwordTextField.text else {
            showAlertUserNameOrPasswordIsWrong()
            return
        }
        
        print(userNameTextField.text)
        print(passwordTextField.text)
        
        UserDefaults.standard.set(userNameTextField.text, forKey: "userName")
        UserDefaults.standard.set(passwordTextField.text, forKey: "password")
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsNC") as! UINavigationController
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
        //MARK: - Private Methods
    
    private func showAlertEnterAllFields() {
        let alert = UIAlertController(title: "Error", message: "All fields should be filled", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertUserNameOrPasswordIsWrong() {
        let alert = UIAlertController(title: "Error", message: "Incorrect user name or password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    
}
