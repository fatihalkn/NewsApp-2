//
//  HomeNewsController.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//

import UIKit


class HomeNewsController: UIViewController, HeaderReusableViewDelegate {
    func didSelectTabs(type: HeaderTabsType) {
        //
    }
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegets()
        setupRegister()
        
    }
    
    func setupDelegets() {
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        
    }
    func setupRegister() {
        homeCollectionView.register(UINib(nibName: HeaderReusableView.identifier,
                                          bundle: nil),
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: HeaderReusableView.identifier)
        homeCollectionView.register(UINib(nibName: HeaderTabsCell.identifier,
                                          bundle: nil),
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: HeaderTabsCell.identifier)
        homeCollectionView.register(UINib(nibName: HeaderTabsCell.identifier,
                                          bundle: nil),forCellWithReuseIdentifier: HeaderTabsCell.identifier)
        homeCollectionView.register(UINib(nibName: HeaderViewCell.identifier, 
                                          bundle: nil),
                                          forCellWithReuseIdentifier: HeaderViewCell.identifier)
       
    }
    
}

//MARK: - CollectionView Configure

extension HomeNewsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            switch collectionView {
            case homeCollectionView:
                let header = homeCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.identifier, for: indexPath) as! HeaderReusableView
                header.delegate = self
                return header
            default:
              return  UICollectionReusableView()
            }
            
        default:
           return UICollectionReusableView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerWidth = collectionView.frame.width 
        let headerHeight = 50.0
        return CGSize(width: headerWidth, height: headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case homeCollectionView:
            return 10
        default:
            return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
        
        
    }
    
    
    
    
}
