//
//  User.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 21.02.2024.
//

import Foundation

struct User: Codable {
    let id: Int
    let name, username, email, phone: String
}
