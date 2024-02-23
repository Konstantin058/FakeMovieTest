//
//  Protocols.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 21.02.2024.
//

import Foundation

protocol Services: AnyObject {
    func reloadData()
}

protocol ApiRequest {
    func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, APIError>) -> Void)
}
