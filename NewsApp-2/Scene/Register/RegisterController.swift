//
//  RegisterController.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//

import UIKit

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
        guard let firstName = firsNameTxtField.text, !firstName.isEmpty else {
            showError(text: "İsim boş bırakılamaz", image: nil, interaction: false, delay: nil)
            return
        }
        
        guard let lastName = lastNameTxtField.text, !lastName.isEmpty else {
            showError(text: "Soyisim boş bırakılamaz", image: nil, interaction: false, delay: nil)
            return
        }
        
        guard let email = emailTxtField.text, !email.isEmpty else {
            showError(text: "Email boş bırakılamaz", image: nil, interaction: false, delay: nil)
            return
        }
        
        guard let password = passwordTxtField.text, !password.isEmpty else {
            showError(text: "Şifre boş bırakılamaz", image: nil, interaction: false, delay: nil)
            return
        }
        
        showLoading(text: nil, interaction: false)
        FirebaseManager.shared.signUpUser(with: email, password: password) { result in
            switch result {
            case .success(let userID):
                if let userID {
                    let userDocumentModel = FirebaseUserDocumentModel(userID: userID,
                                                                      userName: firstName,
                                                                      userEmail: email,
                                                                      userSavedNews: [],
                                                                      userTappedNews: [])

                    FirebaseManager.shared.createUserDocument(userDocumentModel: userDocumentModel) { result in
                        switch result {
                        case .success(_):
                            self.showSucceed(text: "Kayıt işlemi başarıyla tamamlandı", interaction: false, delay: nil)
                        case .failure(let failure):
                            self.showError(text: "Kayıt işlemi başarıyla tamamlandı ✅. Ancak Data Basei oluşturulamadı:❌ \(failure.localizedDescription) .",  image: nil, interaction: false, delay: nil)
                        }
                    }
                    
                    
                } else {
                    self.showError(text: "Kayıt işlemi başarıyla tamamlandı ✅. Ancak USER ID oluşturulamadı. ❌", image: nil, interaction: false, delay: nil)
                }

            case .failure(let failure):
                self.showError(text: "Kayıt işlemi hatası: \(failure.localizedDescription)", image: nil, interaction: false, delay: 2)
            }
        }
    }
    
    
    
}
