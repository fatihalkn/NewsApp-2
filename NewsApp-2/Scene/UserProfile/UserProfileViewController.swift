//
//  UserProfileViewController.swift
//  NewsApp-2
//
//  Created by Fatih on 3.02.2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class UserProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference()
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var uploadPhoto: UIButton!
    
    let db  = Firestore.firestore()
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTab))
        
    }
    
    @objc func imageTab() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        userImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
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
        
        uploadPhoto.layer.cornerRadius = uploadPhoto.frame.height / 2
        uploadPhoto.clipsToBounds = true
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
    
    @IBAction func uploadPhoto(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("İmages")
        
        if let data = userImageView.image?.jpegData(compressionQuality: 0.5) {
            let imageRef = mediaFolder.child("PhotoName")
            imageRef.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    imageRef.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            print(imageUrl)
                        } 
                            
                            
                        
                    }
                    
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
