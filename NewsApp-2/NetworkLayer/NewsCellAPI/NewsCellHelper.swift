//
//  NewsCellHelper.swift
//  NewsApp-2
//
//  Created by Fatih on 28.01.2024.
//

import Foundation

enum EndpointNewsCell: String {
    case technology = "&category=technology"
    case sports = "&category=sports"
    case health = "&category=health"
    case business = "&category=business"
    
    var path: String {
        switch self {
        case .technology:
            return NetworkingHelper.shared.requestUrl(url: EndpointNewsCell.technology.rawValue)
        case .sports:
            return NetworkingHelper.shared.requestUrl(url: EndpointNewsCell.sports.rawValue)
        case .health:
            return NetworkingHelper.shared.requestUrl(url: EndpointNewsCell.health.rawValue)
        case .business:
            return NetworkingHelper.shared.requestUrl(url: EndpointNewsCell.business.rawValue)
        }
    }
}
