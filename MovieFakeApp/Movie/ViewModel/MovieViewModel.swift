//
//  MovieViewModel.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 20.02.2024.
//

import UIKit

class MovieViewModel {
    
    var movies: [Movie] = [] {
        didSet {
            self.movieDelegate?.reloadData()
        }
    }
    weak var movieDelegate: Services?
    private let manager = ApiService()
    
    func fetchMovie() {
        manager.request(url: Constants.movieURL, expecting: [Movie].self) { [weak self] result in
            switch result {
            case .success(let newMovie):
                DispatchQueue.main.async {
                    self?.movies = newMovie
                }
            case .failure(let error):
                print("Error viewModel: \(error)")
            }
        }
    }
}
