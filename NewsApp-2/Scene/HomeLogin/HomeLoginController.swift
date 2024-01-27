//
//  HomeLoginController.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//

import UIKit

class HomeLoginController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var singInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsRadius()
    }
    func buttonsRadius() {
        loginButton.layer.cornerRadius = 10
        singInButton.layer.cornerRadius = 10
    }
    func pushRegisterPage() {
        let registerController = RegisterController()
        navigationController?.pushViewController(registerController, animated: true)
    }
    func pushLoginPage() {
        let loginController = LoginController()
        navigationController?.pushViewController(loginController, animated: true)
    }
    
    @IBAction func singInButton(_ sender: UIButton) {
       pushRegisterPage()
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        pushLoginPage()
        
    }
    

}
