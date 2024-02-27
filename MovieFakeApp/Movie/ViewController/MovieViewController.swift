//
//  MovieVieController.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 20.02.2024.
//

import Foundation
import UIKit

class MovieViewController: TabbarViewController {
    
    var movieViewModel = MovieViewModel()
    
    private var movieCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavBarItem()
        createSubviews()
        addSubviews()
        makeConstraint()
        loadBooksData()
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "videoprojector.fill", title: "Movie")
    }
}

extension MovieViewController {
    
    func createNavBarItem() {
        self.navigationItem.title = "Movies"
    }
    
    func createSubviews() {
        movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }
    
    func addSubviews() {
        view.addSubview(movieCollectionView)
    }
    
    func makeConstraint() {
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            movieCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            movieCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func loadBooksData() {
        DispatchQueue.main.async {
            self.movieViewModel.fetchMovie()
            self.movieViewModel.movieDelegate = self
        }
    }
}

extension MovieViewController: Services {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.movieCollectionView.reloadData()
        }
    }
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieViewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movieContent = movieViewModel.movies.safeObject(at: indexPath.row)
        cell.movieImages = movieContent
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width / 2 - 20, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detaiVC = MovieDetailViewController()
        navigationController?.pushViewController(detaiVC, animated: true)
    }
}
