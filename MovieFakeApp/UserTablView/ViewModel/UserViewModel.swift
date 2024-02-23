//
//  UserViewModel.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 21.02.2024.
//

import Foundation
import UIKit

class UserViewModel {
    
    var users: [User] = [] {
        didSet {
            self.userDelegete?.reloadData()
        }
    }
    weak var userDelegete: Services?
    private let manager = ApiService()
    
    func fetchUsers() {
        manager.request(url: Constants.userUrl, expecting: [User].self) { [weak self] result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self?.users = user
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
