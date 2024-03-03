//
//  Extensiom+UIImage.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 21.02.2024.
//

import UIKit

extension UIImageView {
    
    func loadImage(from urlImage: String) {
        guard let url = URL(string: urlImage) else {
            print("Error fetching image! 🥲")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let newImage = UIImage(data: data) else {
                print("Could load image from url: \(url)")
                return
            }
            
            DispatchQueue.main.async {
                self.image = newImage
            }
        }
        task.resume()
    }
}
