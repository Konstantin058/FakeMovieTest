//
//  ColorCollectionViewCell.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 23.02.2024.
//

import Foundation

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"
    
    let colImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createSubviews()
        addSubiews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageCollectionViewCell {
    
    func createSubviews() {
        colImage.layer.cornerRadius = 20
        colImage.layer.masksToBounds = true
        colImage.contentMode = .scaleAspectFill
    }
    
    func addSubiews() {
        contentView.addSubview(colImage)
    }
    
    func makeConstraints() {
        colImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            colImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            colImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            colImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
