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
    }
    
    func addNews() {
        db.collection("News").addDocument(data: ["newsImageView": article?.urlToImage ?? "",
                                                 "newsTitle": article?.title ?? "",
                                                 "newsYear": article?.publishedAt ?? "",
                                                 "newsDescription": article?.description ?? ""])
        { error in
            if let error = error {
                print("Haber kaydetme hatası: \(error.localizedDescription)")

            } else {
                print("Haber başarıyla kaydedildi.")
            }
            
        }
    }

    
    @IBAction func saveButton(_ sender: UIButton) {
        addNews()
        
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
