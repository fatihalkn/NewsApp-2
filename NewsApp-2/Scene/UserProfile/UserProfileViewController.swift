//
//  UserProfileViewController.swift
//  NewsApp-2
//
//  Created by Fatih on 3.02.2024.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserProfileViewController: UIViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var logOutButton: UIButton!
    
    let db  = Firestore.firestore()
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageRadius()
        textFieldRadius()
        buttonRadius()
        getUserInfo()
    }
    
    func imageRadius() {
        userImageView.layer.cornerRadius = userImageView.frame.size.height / 2
        userImageView.layer.masksToBounds = true
    }
    
    func textFieldRadius() {
        userName.layer.cornerRadius = userName.frame.height / 2
        userName.clipsToBounds = true
        
      
        userEmail.layer.cornerRadius = userEmail.frame.height / 2
        userEmail.clipsToBounds = true
    }
    
    func buttonRadius() {
        logOutButton.layer.cornerRadius = logOutButton.frame.height / 2
        logOutButton.clipsToBounds = true
    }
    
    func getUserInfo() {
        if let user = Auth.auth().currentUser {
            currentUser = user
            updataTextField()
        }
    }
    
    func updataTextField() {
        userEmail.text = currentUser?.email
        
        if let uid = currentUser?.uid {
            let userRef = db.collection("Users").document(uid)
            
            userRef.getDocument { document , error  in
                if let  document = document, document.exists {
                    let userName = document["userName"] as? String
                    self.userName.text = userName
                } else {
                    print("Kullanıcı belirtilen UID ile bulunamadı.")
                }
            }
        }
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            let loginVC = LoginController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true)
        } catch {
            print(error)
        }
    }
    
    
    
    
    
}
