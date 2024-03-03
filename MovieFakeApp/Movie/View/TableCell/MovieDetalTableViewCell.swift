//
//  MovieDetalTableViewCell.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 21.02.2024.
//

import UIKit

class MovieDetalTableViewCell: UITableViewCell {
    
    static let identifier = "cell"
    
    var moviesDetail: Movie? {
        didSet {
            movieConfigureUI()
        }
    }
    
    private var movieImage = UIImageView()
    private var titleLbl = UILabel()
    private var ganreLbl = UILabel()
    private var yearLbl = UILabel()
    private var ratingLbl = UILabel()
    private var directorLbl = UILabel()
    private var actorsLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createAddsubviews()
        addSubviews()
        makeConstrants()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetalTableViewCell {
    
    func createAddsubviews() {
        movieImage.layer.masksToBounds = true
        movieImage.contentMode = .scaleAspectFill
        
        titleLbl.textColor = .black
        titleLbl.textAlignment = .center
        titleLbl.font = .systemFont(ofSize: 20, weight: .bold)
        
        directorLbl.textColor = .darkGray
        directorLbl.textAlignment = .left
        directorLbl.numberOfLines = 0
        directorLbl.font = .systemFont(ofSize: 14, weight: .light)
        
        actorsLbl.textColor = .darkGray
        actorsLbl.textAlignment = .left
        actorsLbl.numberOfLines = 0
        actorsLbl.font = .systemFont(ofSize: 14, weight: .light)
        
        ganreLbl.textColor = .darkGray
        ganreLbl.textAlignment = .left
        ganreLbl.font = .systemFont(ofSize: 14, weight: .light)
        
        yearLbl.textColor = .darkGray
        yearLbl.textAlignment = .left
        yearLbl.font = .systemFont(ofSize: 14, weight: .light)
        
        ratingLbl.textColor = .red
        ratingLbl.textAlignment = .right
        ratingLbl.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    func addSubviews() {
        [movieImage, titleLbl, directorLbl, actorsLbl, ganreLbl, yearLbl, ratingLbl].forEach {
            contentView.addSubview($0)
        }
    }
    
    func makeConstrants() {
        [movieImage, titleLbl, directorLbl, actorsLbl, ganreLbl, yearLbl, ratingLbl].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                movieImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                movieImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                movieImage.bottomAnchor.constraint(equalTo: titleLbl.topAnchor, constant: -10),
                
                titleLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                titleLbl.bottomAnchor.constraint(equalTo: ganreLbl.topAnchor, constant: -15),
                
                ganreLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                ganreLbl.bottomAnchor.constraint(equalTo: yearLbl.topAnchor, constant: -10),
                
                yearLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                yearLbl.bottomAnchor.constraint(equalTo: directorLbl.topAnchor, constant: -10),
                
                ratingLbl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                ratingLbl.bottomAnchor.constraint(equalTo: directorLbl.topAnchor, constant: -10),
                
                directorLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                directorLbl.bottomAnchor.constraint(equalTo: actorsLbl.topAnchor, constant: -10),
                
                actorsLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                actorsLbl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10),
                actorsLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            ])
        }
    }
    
    func movieConfigureUI() {
        guard let moviesDetail else { return }
        titleLbl.text = moviesDetail.title
        ganreLbl.text = moviesDetail.genre.joined(separator: ", ")
        yearLbl.text = "\(moviesDetail.year)"
        ratingLbl.text = "\(moviesDetail.rating)"
        directorLbl.text = moviesDetail.director
        actorsLbl.text = moviesDetail.actors.joined(separator: ", ")
        movieImage.loadImage(from: moviesDetail.poster)
    }
}
