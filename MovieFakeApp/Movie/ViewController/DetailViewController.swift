//
//  DetailViewController.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 21.02.2024.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    let detailViewModel = MovieViewModel()
    
    private var detailTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        
        createNavbarItem()
        createSubviews()
        addSubviews()
        makeConstraint()
        loadBooksData()
    }
}

extension MovieDetailViewController {
    
    func createNavbarItem() {
        self.navigationItem.title = "Detail"
    }
    
    func createSubviews() {
        detailTableView.register(MovieDetalTableViewCell.self, forCellReuseIdentifier: MovieDetalTableViewCell.identifier)
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    func addSubviews() {
        view.addSubview(detailTableView)
    }
    
    func makeConstraint() {
        detailTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailTableView.topAnchor.constraint(equalTo: view.topAnchor),
            detailTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            detailTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            detailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func loadBooksData() {
        DispatchQueue.main.async {
            self.detailViewModel.fetchMovie()
            self.detailViewModel.movieDelegate = self
        }
    }
    
}

extension MovieDetailViewController: Services {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.detailTableView.reloadData()
        }
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetalTableViewCell.identifier, for: indexPath) as? MovieDetalTableViewCell else { return UITableViewCell() }
        
        let movieDetailContent = detailViewModel.movies.safeObject(at: indexPath.row)
        cell.moviesDetail = movieDetailContent
        
        return cell
    }
}
