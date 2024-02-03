//
//  SaveNewsController.swift
//  NewsApp-2
//
//  Created by Fatih on 30.01.2024.
//

import UIKit
import SDWebImage

class SaveNewsController: UIViewController {
    
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

extension SaveNewsController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = saveNewsCollectionView.dequeueReusableCell(withReuseIdentifier: NewsViewCell.identifier, for: indexPath) as! NewsViewCell
        cell.configure(data: savedNews[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width
        let cellHeight: CGFloat = 200
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let selectNews = savedNews[indexPath.item]
          let detailVC = NewsDetailController()
            detailVC.article = selectNews
            detailVC.modalTransitionStyle = .coverVertical
            navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}
