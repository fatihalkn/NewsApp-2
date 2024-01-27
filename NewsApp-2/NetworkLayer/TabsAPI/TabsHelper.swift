//
//  TabsHelper.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//
import Foundation


enum Endpoint: String {
    case technology = "&category=technology"
    case sports = "&category=sports"
    case health = "&category=health"
    case business = "&category=business"
    
    var path: String {
        switch self {
        case .technology:
            return NetworkingHelper.shared.requestUrl(url: Endpoint.technology.rawValue)
        case .sports:
            return NetworkingHelper.shared.requestUrl(url: Endpoint.sports.rawValue)
        case .health:
            return NetworkingHelper.shared.requestUrl(url: Endpoint.health.rawValue)
        case .business:
            return NetworkingHelper.shared.requestUrl(url: Endpoint.business.rawValue)
        }
    }
}
