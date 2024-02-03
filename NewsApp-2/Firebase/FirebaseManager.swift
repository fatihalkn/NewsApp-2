//
//  FirebaseManager.swift
//  NewsApp-2
//
//  Created by Fatih on 3.02.2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

final class FirebaseManager {
    static let shared = FirebaseManager()
    
    //MARK: - References
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    //MARK: - Properties
    var userID: String? {
        return auth.currentUser?.uid
    }
    
    private init() { }
}

//MARK: - Auth Methods
extension FirebaseManager {
    func signUpUser(with email: String, password: String, completion: @escaping ((Result<String?, Error>) -> Void)) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                completion(.failure(error))
                return
            }
            let userID = authResult?.user.uid
            completion(.success(userID))
        }
    }
    
    
    func signInUser(with email: String, password: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
}

//MARK: - Data Base Methods
extension FirebaseManager {
    func createUserDocument(userDocumentModel: FirebaseUserDocumentModel, completion: @escaping ((Result<Void, Error>) -> Void)) {
        let fields: [String: Any] = [
            "userEmail" : userDocumentModel.userEmail,
            "userName" : userDocumentModel.userName,
            "userID" : userDocumentModel.userID,
            "userTappedNews" : userDocumentModel.userTappedNews,
            "userSavedNews" : userDocumentModel.userSavedNews
        ]
        
        db.collection("Users").document(userDocumentModel.userID).setData(fields) { error in
            if let error {
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
        }
    }
    
    func updateUserTappedNews(userID: String, newsTitle: String) {
        fetchUserDocument { result in
            switch result {
            case .success(let userDocument):
                var tappedNews = userDocument.userTappedNews
                if tappedNews.contains(where: { $0 == newsTitle }) {
                    return
                }
                tappedNews.append(newsTitle)
                let userDocumentRef = self.db.collection("Users").document(userID)
                userDocumentRef.updateData(["userTappedNews" : tappedNews]) { error in
                    if let error {
                        print("KULLANICININ TIKLADIGI HABER KAYDEDILEMEDI: \(error.localizedDescription)")
                        return
                    }
                    
                    print("KULLANICININ TIKLADIGI HABER BAŞARIYLA KAYDEDİLDİ")
                }
            case .failure(let failure):
                print("KULLANICININ TIKLADIGI HABERI KAYDETMEK İÇİN fetchUserDocument fonksiyonu tamamlanamadı: \(failure.localizedDescription)")
            }
        }
    }
    
    func updateUserSavedNews(userID: String, newsArticle: Article, willAdd: Bool, completion: @escaping ((Result<Void, Error>) -> Void)) {
        fetchUserDocument { result in
            switch result {
            case .success(let userDocument):
                var savedNews = userDocument.userSavedNews
                
                if willAdd {
                    if savedNews.contains(where: { $0.title == newsArticle.title }) {
                        return
                    }
                    savedNews.append(newsArticle)
                } else {
                    if let indexToDelete = savedNews.firstIndex(where: { $0.title == newsArticle.title }) {
                        savedNews.remove(at: indexToDelete)
                    }
                }
                
                let willUpdateFields = self.converArticleArrayToDictionary(articleArray: savedNews)
                
                let userDocumentRef = self.db.collection("Users").document(userID)
                userDocumentRef.updateData(["userSavedNews" : willUpdateFields]) { error in
                    if let error {
                        print("KULLANICININ HABERİ KAYDEDILEMEDI: \(error.localizedDescription)")
                        completion(.failure(error))
                        return
                    }
                    
                    print("KULLANICININ HABERi BAŞARIYLA KAYDEDİLDİ")
                    completion(.success(()))
                }
            case .failure(let failure):
                print("KULLANICI HABERI KAYDETMEK İÇİN fetchUserDocument fonksiyonu tamamlanamadı: \(failure.localizedDescription)")
                completion(.failure(failure))
            }
        }
    }
    
    
    func fetchUserDocument(completion: @escaping ((Result<FirebaseUserDocumentModel, Error>) -> Void)) {
        // 1. hata kullanıcı olmadığı durum
        // 2. hata get documentin tamamlanmadığı durum
        // 3. hata get yaptığım documenti istediğim model decode edemezsem
        guard let userID = auth.currentUser?.uid else {
            let error = NSError(domain: "KULLANICI BULLUNAMADI", code: 3169)
            completion(.failure(error))
            return
        }
        let userDocumentRef = db.collection("Users").document(userID)
        
        userDocumentRef.getDocument { documentSnapshot, error in
            if let error {
                completion(.failure(error))
            }
            
            let documentSnapshotDictionary = documentSnapshot?.data()
            let jsonDecoder = JSONDecoder()
            if let documentSnapshotDictionary {
                do {
                    let documentSnapshotData = try JSONSerialization.data(withJSONObject: documentSnapshotDictionary)
                    let decodedDocumentSnapshot = try jsonDecoder.decode(FirebaseUserDocumentModel.self, from: documentSnapshotData)
                    completion(.success(decodedDocumentSnapshot))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }
    }
    
    private func converArticleArrayToDictionary(articleArray: [Article]) -> [[String : String]] {
        let dictionaryArray = articleArray.map { [
            "author" : $0.author ?? "",
            "title" : $0.title ?? "",
            "description" : $0.description ?? "",
            "url" : $0.url ?? "",
            "urlToImage" : $0.urlToImage ?? "",
            "publishedAt" : $0.publishedAt ?? "",
            "content" : $0.content ?? ""
        ]}
        
        return dictionaryArray
    }
    
    func checkIsNewsArticleFavorite(newsArticle: Article?, completion: @escaping ((_ isFavorite: Bool) -> Void)) {
        fetchUserDocument { result in
            switch result {
            case .success(let userDocumentData):
                let savedNews = userDocumentData.userSavedNews
                if savedNews.contains(where: { $0.title == newsArticle?.title }) {
                    completion(true)
                } else {
                    completion(false)
                }
            case .failure(_):
                completion(false)
            }
        }
    }
}
