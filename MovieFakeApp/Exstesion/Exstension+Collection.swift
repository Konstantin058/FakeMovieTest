//
//  Exstension+Collection.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 27.02.2024.
//

import UIKit

extension Collection {

    subscript(safe index: Index) -> Element? {
        return safeObject(at: index)
    }

    func safeObject(at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
