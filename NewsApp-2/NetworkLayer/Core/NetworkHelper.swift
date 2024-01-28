//
//  NetworkHelper.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//
// https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=a9f3b2886185493a9a12b08e04272bce

import Foundation


enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

enum ErrorTypes: String, Error {
    case invalidData = "Invalid Data"
    case invalidURL = "Invalid URL"
    case genaralError = "An Error Happened"
}

class NetworkingHelper {
    static let shared = NetworkingHelper()
    let baseURL = "https://newsapi.org/v2/top-headlines?country=us"
    let apıKey = "a9f3b2886185493a9a12b08e04272bce"
    
    
    func requestUrl(url: String)-> String {
        baseURL + url + "&apiKey=\(apıKey)"
        
        
    }
    
    
}
