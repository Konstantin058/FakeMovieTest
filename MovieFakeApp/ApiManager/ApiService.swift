//
//  ApiManager.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 20.02.2024.
//

import Foundation

enum APIError: Error {
    case urlError(String = "Invalid URL adress")
    case serverError(String = "Invalid server error")
    case invalidResponse(String = "Invalid response from server")
    case decodingError(String = "Error parsing server response")
}

class ApiService: ApiRequest {
    
    func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = url else {
            completion(.failure(.urlError()))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error as! APIError))
                } else {
                    completion(.failure(.serverError()))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(.decodingError()))
            }
        }
        task.resume()
    }
}
