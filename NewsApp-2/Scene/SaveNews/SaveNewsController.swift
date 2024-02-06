//
//  SaveNewsController.swift
//  NewsApp-2
//
//  Created by Fatih on 30.01.2024.
//

import UIKit
import SDWebImage
import SwipeCellKit

class SaveNewsController: UIViewController {
    
    
    
    private var isFavorite: Bool = false
    let viewModel = HomeNewsViewModel()
    var savedNews: [Article] = []
    
    @IBOutlet weak var saveNewsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupRegister()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSavedNews()
    }
   
    private func fetchSavedNews() {
        FirebaseManager.shared.fetchUserDocument { result in
            switch result {
            case .success(let userDocument):
                let savedNews = userDocument.userSavedNews
                self.savedNews = savedNews
                DispatchQueue.main.async {
                    self.saveNewsCollectionView.reloadData()
                }
            case .failure(let failure):
                self.showError(text: "Kaydedilen haberleri çekerken hata meydana geldi: \(failure.localizedDescription)", image: nil, interaction: false, delay: 2)
            }
        }
    }
    
    func setupRegister() {
        saveNewsCollectionView.register(UINib(nibName: NewsViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: NewsViewCell.identifier)
        
    }
    
    func setupDelegate(){
        saveNewsCollectionView.delegate = self
        saveNewsCollectionView.dataSource = self
        
    }
    

    
}

extension SaveNewsController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            guard let userID = FirebaseManager.shared.userID else { return }
            FirebaseManager.shared.updateUserSavedNews(userID: userID, newsArticle: self.savedNews[indexPath.item], willAdd: false) { result in
                switch result {
                case .success(let success):
                    self.showSucceed(text: "Silme İşlemş Başarılı", interaction: false, delay: 2)
                    self.savedNews.remove(at: indexPath.item)
                    DispatchQueue.main.async {
                        collectionView.deleteItems(at: [indexPath])
                    }

                case .failure(let failure):
                    if self.isFavorite {
                        self.showError(text: "Haber Kaydedilenlerden kaldırılamadı: \(failure.localizedDescription)", image: nil, interaction: false, delay: 2)
                    }
                }
            }
            
        }

        
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = saveNewsCollectionView.dequeueReusableCell(withReuseIdentifier: NewsViewCell.identifier, for: indexPath) as! NewsViewCell
        cell.configure(data: savedNews[indexPath.item])
        cell.delegate = self
        cell.layer.cornerRadius = 10.0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width - 30
        let cellHeight: CGFloat = 180
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let selectNews = savedNews[indexPath.item]
          let detailVC = NewsDetailController()
            detailVC.article = selectNews
            detailVC.modalTransitionStyle = .coverVertical
            navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
