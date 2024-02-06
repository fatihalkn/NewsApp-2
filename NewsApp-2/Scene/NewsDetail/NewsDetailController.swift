//
//  NewsDetailController.swift
//  NewsApp-2
//
//  Created by Fatih on 28.01.2024.
//

import UIKit
import SDWebImage

class NewsDetailController: UIViewController {
    
    var article: Article?
    private var isFavorite: Bool = false
    @IBOutlet weak var newsWriter: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsYear: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var descView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congfigure()
        updateTappedNews()
        checkIsNewsFavorite()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsImageView.layer.cornerRadius = 30
        newsImageView.clipsToBounds = true
        
    }

    @IBAction func saveButton(_ sender: UIButton) {
        setButtonColor(isFavorite: !isFavorite)
        handleSaveButtonSelection()
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
    
    func handleSaveButtonSelection() {
        guard let userID = FirebaseManager.shared.userID, let article else {
            setButtonColor(isFavorite: isFavorite)
            return
        }
        
        FirebaseManager.shared.updateUserSavedNews(userID: userID, newsArticle: article, willAdd: !isFavorite) { result in
            switch result {
            case .success(_):
                break
            case .failure(let failure):
                self.setButtonColor(isFavorite: false)
                if self.isFavorite {
                    self.showError(text: "Haber Kaydedilenlerden kaldırılamadı: \(failure.localizedDescription)", image: nil, interaction: false, delay: 2)
                } else {
                    self.showError(text: "Haber Kaydedilemedi: \(failure.localizedDescription)", image: nil, interaction: false, delay: 2)
                }
                
            }
        }
    }
    
    func updateTappedNews() {
        guard let userID = FirebaseManager.shared.userID, let newsTitle = article?.title else { return }
        FirebaseManager.shared.updateUserTappedNews(userID: userID, newsTitle: newsTitle)
    }
    
    func checkIsNewsFavorite() {
        showLoading(text: "", interaction: false)
        FirebaseManager.shared.checkIsNewsArticleFavorite(newsArticle: article) { isFavorite in
            self.isFavorite = isFavorite
            self.setButtonColor(isFavorite: isFavorite)
            self.removeLoading()
        }
    }
    
    func setButtonColor(isFavorite: Bool) {
        DispatchQueue.main.async {
            if isFavorite {
                self.saveButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.saveButton.tintColor = .red
            } else {
                self.saveButton.setImage(UIImage(systemName: "heart"), for: .normal)
                self.saveButton.tintColor = .white
            }
        }
    }
    
    
}
