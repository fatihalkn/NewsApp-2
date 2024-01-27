//
//  NewsHomeViewModel.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//
import Foundation


class NewsHomeViewModel {
    let manager = TabsManager.shared
    
    var homeNews: NewsModel?
    var errorCallback: ((String)->())?
    var succesCallback: (()->())?
    
    func getTabsTechnology() {
        manager.getTabsTechnology { [weak self] news, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.homeNews = news
                self?.succesCallback?()
            }
        }
    }
    
    func getTabsSports() {
        manager.getTabsSports { news, error in
            if let error = error {
                self.errorCallback?(error.localizedDescription)
            } else {
                self.homeNews = news
                self.succesCallback?()
            }
        }
        
    }
    
    func getTabsHealth() {
        manager.getTabsHealth { news, error in
            if let error = error {
                self.errorCallback?(error.localizedDescription)
            } else {
                self.homeNews = news
                self.succesCallback?()
            }
        }
        
    }
    
    func getTabsBusiness() {
        manager.getTabsBusiness { news, error in
            if let error = error {
                self.errorCallback?(error.localizedDescription)
            } else {
                self.homeNews = news
                self.succesCallback?()
                
            }
        }
        
    }
}
