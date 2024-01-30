//
//  RegisterController.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


class RegisterController: UIViewController {
    
    
    var docRef: DocumentReference!
    @IBOutlet weak var firsNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        docRef = Firestore.firestore().document("Users/NewsApp")
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
        
        guard let firsNameTxtField = firsNameTxtField.text, !firsNameTxtField.isEmpty else { return }
        guard let lastNameTxtField = lastNameTxtField.text, !lastNameTxtField.isEmpty else { return }
        guard let emailTxtField = emailTxtField.text, !emailTxtField.isEmpty else { return }
        guard let passwordTxtField = passwordTxtField.text, !passwordTxtField.isEmpty else { return }
        let dataSave: [String: Any] = ["name": firsNameTxtField,
                                       "lastname": lastNameTxtField,
                                       "email": emailTxtField,
                                       "password": passwordTxtField]
        docRef.setData(dataSave) { (error) in
            if let error = error {
                print("error")
            } else {
                print("Data kaydedildi")
            }
        }
    }
    
    
}
