//
//  HomeNewsViewModel.swift
//  NewsApp-2
//
//  Created by Fatih on 28.01.2024.
//

import Foundation



class HomeNewsViewModel {
    let manager = NewsCellManeger.shared
    
    var homeNews: NewsModel?
    var errorCallback: ((String)->())?
    var succesCallback: (()->())?
    var currentSelectedTypeUpdated: ((_ beforeTabType: HeaderTabsType, _ afterTabType: HeaderTabsType) -> ())?
    var currentSelectedHeaderCategoryType: HeaderTabsType = .business
    
    func getNewsTechnology() {
        manager.getNewsTechnology { [weak self] news , error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.homeNews = news
                self?.succesCallback?()
            }
        }
    }
    
    func getNewsSports() {
        manager.getNewsSports { [weak self] news , error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.homeNews = news
                self?.succesCallback?()
            }
        }
    }
    
    func getNewsHealth() {
        manager.getNewsHealth { [weak self] news , error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.homeNews = news
                self?.succesCallback?()
            }
        }
    }
    
    func getNewsBusiness() {
        manager.getNewsBusiness { [weak self] news , error  in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
                
            } else {
                self?.homeNews = news
                self?.succesCallback?()
            }
        }
        
    }
    
    func didSelectHeaderCategoryTab(_ type: HeaderTabsType) {
        currentSelectedTypeUpdated?(self.currentSelectedHeaderCategoryType, type)
        currentSelectedHeaderCategoryType = type
        switch type {
        case .business:
            getNewsBusiness()
        case .technology:
            getNewsTechnology()
        case .sports:
            getNewsSports()
        case .health:
            getNewsHealth()
        }
    }
    
}
