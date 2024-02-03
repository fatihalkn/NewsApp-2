//
//  FirebaseUserDocumentModel.swift
//  NewsApp-2
//
//  Created by Fatih on 3.02.2024.
//

import Foundation

struct FirebaseUserDocumentModel: Codable {
    let userID: String
    let userName: String
    let userEmail: String
    let userSavedNews: [Article]
    let userTappedNews: [String]
}
