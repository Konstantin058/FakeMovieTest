//
//  UserTableViewCell.swift
//  MovieFakeApp
//
//  Created by Константин Евсюков on 21.02.2024.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    static let identifier = "Cell"

    var user: User? {
        didSet {
            userConfigureUI()
        }
    }

    private var nameLabel = UILabel()
    private var userNameLabel = UILabel()
    private var emailLBL = UILabel()
    private var phoneLbl = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setAddSubViews1()
        configureSubviews1()
        setConstraints1()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func userConfigureUI() {
        guard let user else { return }
        nameLabel.text = "User Name: \(user.name)"
        userNameLabel.text = "User Nickname: \(user.username)"
        emailLBL.text = "E-mail: \(user.email)"
        phoneLbl.text = "Phone: \(user.phone)"
    }
}

extension UserTableViewCell {

    func configureSubviews1() {
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)

        userNameLabel.textColor = .black
        userNameLabel.textAlignment = .left
        userNameLabel.numberOfLines = 0
        userNameLabel.font = .systemFont(ofSize: 12, weight: .regular)

        emailLBL.textColor = .gray
        emailLBL.textAlignment = .left
        emailLBL.font = .systemFont(ofSize: 12, weight: .regular)
        
        phoneLbl.textColor = .gray
        phoneLbl.textAlignment = .left
        phoneLbl.font = .systemFont(ofSize: 12, weight: .regular)
    }

    func setAddSubViews1() {
        [nameLabel, userNameLabel, emailLBL, phoneLbl].forEach {
            contentView.addSubview($0)
        }
    }

    func setConstraints1() {
        [nameLabel, userNameLabel, emailLBL, phoneLbl].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                nameLabel.bottomAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: -10),

                userNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                userNameLabel.bottomAnchor.constraint(equalTo: emailLBL.topAnchor, constant: -10),
                
                emailLBL.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                emailLBL.bottomAnchor.constraint(equalTo: phoneLbl.topAnchor, constant: -10),

                phoneLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                phoneLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            ])
        }
    }
}
