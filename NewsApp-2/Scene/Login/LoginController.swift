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
    @IBOutlet weak var errorLink: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonRadius()
        configreNav()
        
    }
    
    func pushHomeNews() {
        let homeNewsController = TabController()
        homeNewsController.modalPresentationStyle = .fullScreen
        present(homeNewsController, animated: true)
    }
    
    func configreNav() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func buttonRadius() {
        loginButton.layer.cornerRadius = 10
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        
        guard let email = emailTxtField.text, !email.isEmpty else {
            showError(text: "Email boş bırakılamaz", image: nil, interaction: false, delay: nil)
            return
        }
        
        guard let password = passwordTxtField.text, !password.isEmpty else {
            showError(text: "Şifre boş bırakılamaz", image: nil, interaction: false, delay: nil)
            return
        }
        
        showLoading(text: nil, interaction: false)
        FirebaseManager.shared.signInUser(with: email, password: password) { result in
            switch result {
            case .success(_):
                self.showSucceed(text: "Giriş işlemi başarılı", interaction: false, delay: nil)
                self.pushHomeNews()
            case .failure(let failure):
                self.showError(text: "Giriş işlemi başarısız: \(failure.localizedDescription)", image: nil, interaction: false, delay: 2)
            }
        }
    }
    
    
    
    

}

