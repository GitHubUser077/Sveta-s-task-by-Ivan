//
//  SettingsViewController.swift
//  Sveta's task by Ivan
//
//  Created by mac on 06.05.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
        //MARK: - Dependencies
    var meUser: SimpleUser!

    
        //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(didTapLogoutBarButton))
    }
    
    
        //MARK: - Private Methods
    @objc private func didTapLogoutBarButton() {
        print("User logout")
        UserDefaults.standard.removeObject(forKey: "userName")
        
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        
        loginVC.modalTransitionStyle = .crossDissolve
        loginVC.modalPresentationStyle = .fullScreen
        
        present(loginVC, animated: true, completion: nil)
        
    }

   

}
