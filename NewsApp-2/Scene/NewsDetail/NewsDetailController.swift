//
//  NewsDetailController.swift
//  NewsApp-2
//
//  Created by Fatih on 28.01.2024.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseFirestore

class NewsDetailController: UIViewController {
    
    var favoriteNews: [Article] = []
    let db = Firestore.firestore()
    var article: Article?
    @IBOutlet weak var newsWriter: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsYear: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congfigure()
        fetchFavoriteNews()
      
    }
    
    func isNewsFavorite() -> Bool {
        let returnValue = favoriteNews.map({$0.title}).contains(where: {$0 == article?.title})
        return returnValue
    }
    
    
    func addNews() {
        var ref: DocumentReference?
       ref = db.collection("News").addDocument(data: ["newsImageView": article?.urlToImage ?? "",
                                                 "newsTitle": article?.title ?? "",
                                                 "newsYear": article?.publishedAt ?? "",
                                                 "newsDescription": article?.description ?? ""])
        
        { error in
            if let error = error {
                print("Haber kaydetme hatası: \(error.localizedDescription)")

            } else {
                if let docID = ref?.documentID {
                    print("Haber başarıyla kaydedildi DocID: \(docID).")

                } else {
                    print("Document ID alınamadı.")
                }
            }
        }
    }
    
    func deleteNews() {
        db.collection("News").whereField("newsTitle", isEqualTo: article?.title ?? "").getDocuments { snapshot, error in
            if let error = error {
                print("Silme işlemi başarısız: \(error.localizedDescription)")

            }
            
            for dociment in snapshot!.documents {
                dociment.reference.delete()
                print("Haber başarıyla silindi.")
                
            }
        }
    }
    
    func fetchFavoriteNews() {
        db.collection("News").getDocuments { snapshot, error in
            if let error = error {
                print("Favoriye eklenen haberler alınamadı \(error)")
                return
            }
            
            for document in snapshot!.documents {
                let data = document.data()
                let title = data["newsTitle"] as? String
                let news = Article(source: nil, author: nil, title: title, description: nil, url: nil, urlToImage: nil, publishedAt: nil, content: nil)
                self.favoriteNews.append(news)
            }
            
            if self.isNewsFavorite() {
                self.saveButton.tintColor = UIColor.red
            } else {
                self.saveButton.tintColor = UIColor.white
            }
            
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        if sender.tintColor == UIColor.white {
            sender.tintColor = UIColor.red
            addNews()
        } else {
            sender.tintColor = UIColor.white
            deleteNews()
            
            
        }
    }
    
    func congfigure() {
        if let data = article {
            self.article = data
            newsWriter?.text = data.author
            newsTitle?.text = data.title
            newsYear?.text = data.publishedAt
            newsDescription?.text = data.content
            newsImageView?.sd_setImage(with: URL(string: data.urlToImage ?? ""))
        } else {
          print("hata")
        }
    }
}
