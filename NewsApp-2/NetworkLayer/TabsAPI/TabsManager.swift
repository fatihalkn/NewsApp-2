//
//  TabsManager.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//

import Foundation

protocol TabsProtocol {
    func getTabsTechnology(complete: @escaping(NewsModel?, Error?) -> ())
    func getTabsSports(complete: @escaping(NewsModel?, Error?) -> ())
    func getTabsHealth(complete: @escaping(NewsModel?, Error?) -> ())
    func getTabsBusiness(complete: @escaping(NewsModel?, Error?) -> ())
}


class TabsManager : TabsProtocol {
    
    static let shared = TabsManager()
    
    func getTabsTechnology(complete: @escaping (NewsModel?, Error?) -> ()) {
        NetworkManager.shared.request(type: NewsModel.self, url: Endpoint.technology.path, method: .get) { response in
            switch response {
            case .success(let data):
            complete(data, nil)
            case .failure(let error):
                print("Error in getTabsTechnology: \(error)")
                complete(nil, error)
            }
        }
    }
    
    func getTabsSports(complete: @escaping (NewsModel?, Error?) -> ()) {
        NetworkManager.shared.request(type: NewsModel.self, url: Endpoint.sports.path, method: .get) { resposne  in
            switch resposne {
                
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                print("Error in getTabsSports: \(error)")
                complete(nil, error)
            }
        }
    }
    
    func getTabsHealth(complete: @escaping (NewsModel?, Error?) -> ()) {
        NetworkManager.shared.request(type: NewsModel.self, url: Endpoint.health.path, method: .get) { response in
            switch response {
                
            case .success(let data):
                complete(data,nil)
            case .failure(let error):
                print("Error in getTabsHealth: \(error)")
                complete(nil,error)
            }
        }
    }
    
    func getTabsBusiness(complete: @escaping (NewsModel?, Error?) -> ()) {
        NetworkManager.shared.request(type: NewsModel.self, url: Endpoint.business.path, method: .get) { result in
            switch result {
                
            case .success(let data):
                complete(data,nil)
            case .failure(let error):
                print("Error in getTabsBusiness: \(error)")
                complete(nil,error)
            }
        }
    }
    
    
}
