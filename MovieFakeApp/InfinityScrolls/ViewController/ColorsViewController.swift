//
//  ColorsViewController.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 23.02.2024.
//

import Foundation
import UIKit

class ColorsViewController: TabbarViewController {
    
    private var pageCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    var imageColors = [UIColor]()
    var loadingView: LoadingReusableView?
    var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavBarItem()
        createSubviews()
        addSubviews()
        makeConstraints()
        reloadData()
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "paintbrush", title: "Colors")
    }
}

extension ColorsViewController {
    
    func createNavBarItem() {
        self.navigationItem.title = "Colors"
    }
    
    func createSubviews() {
        pageCollectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: PageCollectionViewCell.identifier)
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        
        pageCollectionView.register(LoadingReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingReusableView.identifier)
    }
    
    func addSubviews() {
        view.addSubview(pageCollectionView)
    }
    
    func makeConstraints() {
        pageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            pageCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            pageCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            pageCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func reloadData() {
        isLoading = false
        pageCollectionView.collectionViewLayout.invalidateLayout()
        
        for _ in 0...20 {
            imageColors.append(createRandomColor())
        }
    }
    
    func createRandomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        return color
    }
    
    func loadData() {
        if !isLoading {
            isLoading = true
            let start = imageColors.count
            let end = start + 10
            
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
                for _ in start...end {
                    self.imageColors.append(self.createRandomColor())
                }
                DispatchQueue.main.async {
                    self.pageCollectionView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
}

extension ColorsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCollectionViewCell.identifier, for: indexPath) as? PageCollectionViewCell else { return UICollectionViewCell() }
        
        cell.colImage.backgroundColor = imageColors[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == imageColors.count - 10, !isLoading {
            loadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: pageCollectionView.bounds.size.width, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingReusableView.identifier, for: indexPath) as! LoadingReusableView
            loadingView = footerView
            loadingView?.backgroundColor = .clear
            return footerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
}
