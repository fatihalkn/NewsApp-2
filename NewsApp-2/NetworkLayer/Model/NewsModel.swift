//
//  NewsModel.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsModel = try? JSONDecoder().decode(NewsModel.self, from: jsonData)

import Foundation

// MARK: - NewsModel
struct NewsModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}
