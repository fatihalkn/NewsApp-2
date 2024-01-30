//
//  HomeNewsController.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//

import UIKit
import SafariServices


class HomeNewsController: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    
    let viewModel = HomeNewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegets()
        setupRegister()
        viewModelConfigure()
        
    }
    
    fileprivate func viewModelConfigure() {
        viewModel.getNewsTechnology()
        viewModel.errorCallback = { errorMessage in
            print("error: \(errorMessage)")
            
        }
        
        viewModel.succesCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.homeCollectionView.reloadData()
            }
            
        }
        
        viewModel.currentSelectedTypeUpdated = { [weak self] beforeTabType, afterTabType in
            guard let header = self?.homeCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? HeaderReusableView else { return }
            header.selectTabCell(beforeTabType: beforeTabType, afterTabType: afterTabType)
        }
        
    }
    
    @IBAction func savePage(_ sender: UIButton) {
        let vc = SaveNewsController()
        navigationController?.pushViewController(vc, animated: true)
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
        homeCollectionView.register(UINib(nibName: NewsViewCell.identifier,
                                          bundle: nil),
                                    forCellWithReuseIdentifier: NewsViewCell.identifier)
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
                header.configure(data: viewModel.homeNews?.articles ?? [], currentSelectedTabType: viewModel.currentSelectedHeaderCategoryType)
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
        let headerHeight = 200.0
        return CGSize(width: headerWidth, height: headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case homeCollectionView:
            return viewModel.homeNews?.articles?.count ?? 0
        default:
            return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: NewsViewCell.identifier, for: indexPath) as! NewsViewCell
        let newModel = viewModel.homeNews?.articles?[indexPath.item]
        cell.configure(data: newModel)
        cell.delegate = self
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat =  collectionView.frame.width
        let cellHigth: CGFloat = 180
        return(.init(width: cellWidth, height: cellHigth))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedNews = viewModel.homeNews?.articles?[indexPath.item] {
            let detilVc = NewsDetailController()
            detilVc.article = selectedNews
            detilVc.modalTransitionStyle = .coverVertical
            navigationController?.pushViewController(detilVc, animated: true)
            
        } else {
            print("HATA")
            
        }
        
        
        
        
    }
    
}

//MARK: - HeaderReusableViewDelegate
extension HomeNewsController: HeaderReusableViewDelegate {
    func didSelectTabs(type: HeaderTabsType) {
        viewModel.didSelectHeaderCategoryTab(type)
    }
    
}

//MARK: - NewsViewCellDelegate
extension HomeNewsController: NewsViewCellDelegate {
    func openNewsURLTapped(url: String?) {
        let safariVC = SFSafariViewController(url: URL(string: url ?? "")!)
        navigationController?.pushViewController(safariVC, animated: true)
    }
    
    
}
