//
//  Movie.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 20.02.2024.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let year: Int
    let genre: [String]
    let rating: Double
    let director: String
    let actors: [String]
    let plot: String
    let poster: String
    let awards: String
}
