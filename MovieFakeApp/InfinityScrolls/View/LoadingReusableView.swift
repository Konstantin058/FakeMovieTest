//
//  LoadingReusableView.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 23.02.2024.
//

import Foundation
import UIKit

class LoadingReusableView: UICollectionViewCell {
    
    static let identifier = "loading"
    
    var activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension LoadingReusableView {
    
    func createSubView() {
        activityIndicator.color = UIColor.white
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
