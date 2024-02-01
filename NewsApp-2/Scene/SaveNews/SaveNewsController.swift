//
//  SaveNewsController.swift
//  NewsApp-2
//
//  Created by Fatih on 30.01.2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

class SaveNewsController: UIViewController {
    
    
    
    var newsArry: [Article] = []
    let db = Firestore.firestore()
    @IBOutlet weak var saveNewsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupRegister()
        fetchFireStoreNews()
        
        
    }
    
   
    
    
    
    func setupRegister() {
        saveNewsCollectionView.register(UINib(nibName: NewsViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: NewsViewCell.identifier)
        
    }
    
    func setupDelegate(){
        saveNewsCollectionView.delegate = self
        saveNewsCollectionView.dataSource = self
        
    }
    
    
    func fetchFireStoreNews() {
        db.collection("News").getDocuments { snapshot, error in
            if let error = error {
                print("Haberleri alma hatası: \(error.localizedDescription)")
                return
            }
            
            for document in snapshot!.documents {
                let data = document.data()
                let title = data["newsTitle"] as? String
                let description = data["newsDescription"] as? String
                let pulishat = data["newsYear"] as? String
                let ımage = data["newsImageView"] as? String
                let documentId = document.documentID
                let news = Article(source: nil, author: nil, title: title, description: description, url: nil, urlToImage: ımage, publishedAt: pulishat, content: nil)
                self.newsArry.append(news)
                
            }
            
            DispatchQueue.main.async {
                self.saveNewsCollectionView.reloadData()
            }
        }
    }
    
    
    
}

extension SaveNewsController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = saveNewsCollectionView.dequeueReusableCell(withReuseIdentifier: NewsViewCell.identifier, for: indexPath) as! NewsViewCell
        cell.configure(data: newsArry[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width
        let cellHeight: CGFloat = 200
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
