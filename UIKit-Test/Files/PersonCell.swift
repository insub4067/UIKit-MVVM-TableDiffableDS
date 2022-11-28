//
//  PeopleCell.swift
//  UIKit-Test
//
//  Created by Kim Insub on 2022/11/28.
//

import UIKit

class PersonCell: UITableViewCell {

    static let reuseID = "PersonCell"

    let usernameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(person: Person) {
        usernameLabel.text = person.name
    }

    private func configure() {
        addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 12

        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: padding)
        ])
    }
}
