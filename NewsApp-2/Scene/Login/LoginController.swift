//
//  LoginController.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonRadius()
    }
    
    func pushHomeNews() {
        let homeNewsController = HomeNewsController()
        navigationController?.pushViewController(homeNewsController, animated: true)
    }
    
    func buttonRadius() {
        loginButton.layer.cornerRadius = 10
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        pushHomeNews()
    }
    
    
    
    
}
