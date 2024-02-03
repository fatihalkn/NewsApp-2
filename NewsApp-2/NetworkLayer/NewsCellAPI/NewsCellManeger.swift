//
//  NewsCellManeger.swift
//  NewsApp-2
//
//  Created by Fatih on 28.01.2024.
//

import Foundation


protocol NewsCellProtocol {
    func getNewsTechnology(complete: @escaping(NewsModel?, Error?) -> ())
    func getNewsSports(complete: @escaping(NewsModel?, Error?) -> ())
    func getNewsHealth(complete: @escaping(NewsModel?, Error?) -> ())
    func getNewsBusiness(complete: @escaping(NewsModel?, Error?) -> ())
}


class NewsCellManeger: NewsCellProtocol {
    static let shared = NewsCellManeger()
    
    func getNewsTechnology(complete: @escaping (NewsModel?, Error?) -> ()) {
        NetworkManager.shared.request(type: NewsModel.self, url: EndpointNewsCell.technology.path, method: .get) { response in
            print(EndpointNewsCell.technology.path)
            switch response {
            case .success(let data):
                complete(data,nil)
            case .failure(let error):
                print("Eror getNewsTechnology \(error.localizedDescription)")
                complete(nil,error)
            }
        }
    }
    
    func getNewsSports(complete: @escaping (NewsModel?, Error?) -> ()) {
        NetworkManager.shared.request(type: NewsModel.self, url: EndpointNewsCell.sports.path, method: .get) { result in
            switch result {
                
            case .success(let data):
                complete(data,nil)
            case .failure(let error):
                print("Eror getNewsSports \(error.localizedDescription)")
                complete(nil,error)
            }
        }
    }
    
    func getNewsHealth(complete: @escaping (NewsModel?, Error?) -> ()) {
        NetworkManager.shared.request(type: NewsModel.self, url: EndpointNewsCell.health.path, method: .get) { response in
            switch response {
            case .success(let data):
                complete(data,nil)
            case.failure(let error):
                print("Error getNewsHealth \(error.localizedDescription)")
                complete(nil,error)
            }
        }
    }
    
    func getNewsBusiness(complete: @escaping (NewsModel?, Error?) -> ()) {
        NetworkManager.shared.request(type: NewsModel.self, url: EndpointNewsCell.business.path, method: .get) { response in
            switch response {
            case .success(let data):
                complete(data,nil)
            case.failure(let error):
                print("Error getNewsBusiness \(error.localizedDescription)")
                complete(nil,error)
            }
        }
    }
    
    
}
