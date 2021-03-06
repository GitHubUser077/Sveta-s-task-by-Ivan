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
        
        let appTabBarController = storyboard?.instantiateViewController(withIdentifier: "AppTabBar") as! UITabBarController
        
//        let meUser = SimpleUser(name: "Ivan", avatarImage: "mountain1", photos: [SimplePhoto(name: "phone1"),SimplePhoto(name: "phone2"),SimplePhoto(name: "phone3")], groups: [], friends: testUsers)
//        
//        let friendsVC = storyboard?.instantiateViewController(withIdentifier: "FriendsViewController") as! FriendsViewController
//        
//        friendsVC.meUser = meUser
//        
////        let nVC = UINavigationController(rootViewController: friendsVC)
        
        appTabBarController.modalPresentationStyle = .fullScreen
        appTabBarController.modalTransitionStyle = .flipHorizontal
        
        present(appTabBarController, animated: true, completion: nil)
        
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
