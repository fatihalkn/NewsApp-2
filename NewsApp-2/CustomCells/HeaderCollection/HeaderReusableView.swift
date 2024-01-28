//
//  HeaderReusableView.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//

import UIKit



struct HeaderTabsData {
    let title: String
    let type: HeaderTabsType
}

enum HeaderTabsType {
    case business
    case technology
    case sports
    case health
}

protocol HeaderReusableViewDelegate: AnyObject {
    func didSelectTabs(type: HeaderTabsType)
}

class HeaderReusableView: UICollectionReusableView {
    static let identifier = "HeaderReusableView"
    @IBOutlet weak var newsPhotoCollction: UICollectionView!
    @IBOutlet weak var newsCatagoryCollection: UICollectionView!
    
    var news: [Article] = []
    let tabDatas: [HeaderTabsData] = [.init(title: "Business", type: .business),
                                      .init(title: "Technology", type: .technology),
                                      .init(title: "Sports", type: .sports),
                                      .init(title: "Health", type: .health)
    ]
    var currentSelectedTabType: HeaderTabsType?
    
    var delegate: HeaderReusableViewDelegate?
    
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDelegets()
        setupRegister()
        
    }
    
    func setupDelegets() {
        newsPhotoCollction.dataSource = self
        newsPhotoCollction.delegate = self
        newsCatagoryCollection.dataSource = self
        newsCatagoryCollection.delegate = self
    }
    
    func setupRegister() {
        newsPhotoCollction.register(UINib(nibName: HeaderViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: HeaderViewCell.identifier)
        newsCatagoryCollection.register(UINib(nibName: HeaderTabsCell.identifier, bundle: nil),forCellWithReuseIdentifier: HeaderTabsCell.identifier)
    }
    
    func configure(data news: [Article], currentSelectedTabType: HeaderTabsType) {
        self.news = news
        self.currentSelectedTabType = currentSelectedTabType
        DispatchQueue.main.async { [weak self] in
            self?.newsPhotoCollction.reloadData()
        }
    }
    
    func selectTabCell(beforeTabType: HeaderTabsType, afterTabType: HeaderTabsType) {
        if let beforeCell = getTabCellFor(tabType: beforeTabType) {
            beforeCell.backgroundColor = .clear
        }
        
        if let afterCell = getTabCellFor(tabType: afterTabType) {
            afterCell.backgroundColor = .systemGray2
        }
        
    }
    
    func getTabCellFor(tabType: HeaderTabsType) -> HeaderTabsCell? {
        if let tabIndex = tabDatas.firstIndex(where: { $0.type == tabType }) {
            let indexPath = IndexPath(item: tabIndex, section: 0)
            guard let cell = newsCatagoryCollection.cellForItem(at: indexPath) as? HeaderTabsCell else { return nil }
            return cell
        } else {
            return nil
        }
    }
}

//MARK: - CollectionView Configure

extension HeaderReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case newsPhotoCollction:
            return news.count
        case newsCatagoryCollection:
            return tabDatas.count
        default:
            return .init()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case newsPhotoCollction:
            let cell = newsPhotoCollction.dequeueReusableCell(withReuseIdentifier: HeaderViewCell.identifier, for: indexPath) as! HeaderViewCell
            let new = news[indexPath.item]
            cell.configure(data: new)
            return cell
        case newsCatagoryCollection:
            let cell = newsCatagoryCollection.dequeueReusableCell(withReuseIdentifier: HeaderTabsCell.identifier, for: indexPath) as! HeaderTabsCell
            let cellType = tabDatas[indexPath.item].type
            if currentSelectedTabType == cellType {
                cell.backgroundColor = .clear
            } else {
                cell.backgroundColor = .systemGray2
            }
            
            cell.headerTabsLabel.text = tabDatas[indexPath.item].title
            return cell
        default:
            return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case newsPhotoCollction:
            let cellWidth: CGFloat = collectionView.frame.width
            let cellHeight: CGFloat = collectionView.frame.height
            return .init(width: cellWidth, height: cellHeight)
        case newsCatagoryCollection:
            let cellWidth: CGFloat = collectionView.frame.width / 4
            let cellHeight: CGFloat = collectionView.frame.height
            return CGSize(width: cellWidth, height: cellHeight)
        default: return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        newsCatagoryCollection.deselectItem(at: indexPath, animated: true)
        let selectedType = tabDatas[indexPath.item].type
        delegate?.didSelectTabs(type: selectedType)
    }
    
}
