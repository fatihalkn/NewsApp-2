//
//  RegisterController.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//

import UIKit
import Firebase
import FirebaseAuth


class RegisterController: UIViewController {
    @IBOutlet weak var firsNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonRadius()
    }
    
    func buttonRadius() {
        registerButton.layer.cornerRadius = 10
    }
    
    func pushLoginPage() {
        let loginController = LoginController()
        navigationController?.pushViewController(loginController, animated: true)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if let email = emailTxtField.text, let password = passwordTxtField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.pushLoginPage()
                }
             
            }
        }
        
    }
    
    
}
