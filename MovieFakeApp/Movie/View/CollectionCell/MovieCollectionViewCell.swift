//
//  MovieCollectionViewCell.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 20.02.2024.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"
    
    let movieImage = UIImageView()
    
    var movieImages: Movie? {
        didSet {
            movieConfigureUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createAddsubviews()
        addSubviews()
        makeConstrants()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieCollectionViewCell {
    
    func createAddsubviews() {
        movieImage.layer.cornerRadius = 20
        movieImage.layer.masksToBounds = true
        movieImage.contentMode = .scaleAspectFill
    }
    
    func addSubviews() {
        [movieImage].forEach {
            contentView.addSubview($0)
        }
    }
    
    func makeConstrants() {
        [movieImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                movieImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                movieImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
                movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            ])
        }
    }
    
    func movieConfigureUI() {
        guard let movieImages else { return }
        movieImage.loadImage(from: movieImages.poster)
    }
}
