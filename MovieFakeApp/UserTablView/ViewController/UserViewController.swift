//
//  UserViewController.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 21.02.2024.
//

import UIKit

class UserViewController: TabbarViewController {
    
    var userViewModel = UserViewModel()
    
    private var userTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavBarItem()
        createSubviews()
        addSubviews()
        makeConstraints()
        loadViewModel()
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "person", title: "UserTable")
    }
}

extension UserViewController {
    
    func createNavBarItem() {
        self.navigationItem.title = "Users"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddButton))
    }
    
    func createSubviews() {
        userTableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.separatorStyle = .none
    }
    
    
    func addSubviews() {
        [userTableView].forEach {
            view.addSubview($0)
        }
    }
    
    func makeConstraints() {
        [userTableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: view.topAnchor),
            userTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            userTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            userTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func loadViewModel() {
        userViewModel.userDelegete = self
        userViewModel.fetchUsers()
    }
    
    @objc func tapAddButton() {
        userViewModel.users.append(User.init(id: 1, name: "Jonh", username: "JonhBells", email: "newUser@mail.com", phone: "+79111111111"))
    }
}

extension UserViewController: Services {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.userTableView.reloadData()
        }
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell() }
        
        let userContent = userViewModel.users.safeObject(at: indexPath.row)
        cell.user = userContent
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userViewModel.users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
