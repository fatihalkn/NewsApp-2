//
//  LoginController.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginController: UIViewController {
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLink: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonRadius()
        checkLogginUserControl()
    }
    
    func pushHomeNews() {
        let homeNewsController = TabController()
        navigationController?.pushViewController(homeNewsController, animated: true)
    }
    
    func buttonRadius() {
        loginButton.layer.cornerRadius = 10
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = emailTxtField.text else { return }
        guard let password = passwordTxtField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if(error != nil) {
                let alert = UIAlertController(title: "Login Error", message: "Your email or password is incorrect!", preferredStyle: .alert)
                self?.present(alert, animated: true)
                let okButton = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okButton)
                return
                
            } else {
                let alert = UIAlertController(title: "Login successful!", message: "If you press the arrow button, you will be directed to your home page.", preferredStyle: .alert)
                self?.present(alert, animated: true)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self?.pushHomeNews()
                })
                alert.addAction(okButton)
            }
        }
        
    }
    
    func checkLogginUserControl() {
         Auth.auth().addStateDidChangeListener { auth, user in
          
        }
        
    }
    
    
    
}
