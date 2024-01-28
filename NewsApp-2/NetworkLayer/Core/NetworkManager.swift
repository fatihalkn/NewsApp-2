//
//  NetworkManager.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func request<T: Codable>(type: T.Type , url: String, method: HTTPMethods, completion: @escaping((Result<T, ErrorTypes>)->())) {
        let session = URLSession.shared
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            let dataTask = session.dataTask(with: request) { data, request, error in
                if let error = error {
                    completion(.failure(.genaralError))
                }
                
                if let data = data {
                    self.handResponse(data: data) { response in
                        completion(response)
                    }
                } else {
                    completion(.failure(.invalidURL))
                }
                
            }
            dataTask.resume()
        }
        
    }
    
    fileprivate func handResponse<T: Codable>(data: Data, completion: @escaping((Result<T, ErrorTypes>)->()) ) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
            
        } catch {
            completion(.failure(.invalidData))
        }
    }
    
}
