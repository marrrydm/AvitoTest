//
//  CellTableViewCell.swift
//  AvitoTest
//
//  Created by Мария Ганеева on 23.10.2022.
//

import UIKit

final class ViewCell: UITableViewCell {

    // MARK: - Private Properties
    let nameLabel = UILabel()
    let contentLabel = UILabel()
    let skillsLabel = UILabel()
    let phoneLabel = UILabel()

    // MARK: - Constants
    enum Constants {
        static let id = "Cell"
        static let contentLabelBackgroundColor = UIColor(red: 0.172, green: 0.172, blue: 0.172, alpha: 1)
    }

    // MARK: - Init

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    // MARK: - Private Methods UI

    private func configureUI() {
        backgroundColor = .white

        addSubview(nameLabel)
        addSubview(contentLabel)
        addSubview(skillsLabel)
        addSubview(phoneLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false

        setupLabels()
    }
    
    private func setupLabels() {
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        contentLabel.font = .systemFont(ofSize: 14, weight: .regular)
        skillsLabel.font = .systemFont(ofSize: 14, weight: .bold)
        phoneLabel.font = .systemFont(ofSize: 14, weight: .regular)
        contentLabel.textColor = Constants.contentLabelBackgroundColor

        constraintsNameLabel()
        constraintsContentLabel()
        constraintsSkillsLabel()
        constraintsPhoneLabel()
    }

    private func constraintsNameLabel() {
        let topConstraint = nameLabel.topAnchor.constraint(
            equalTo: self.topAnchor,
            constant: 10
        )
        let trailingConstraint = nameLabel.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: 16
        )
        let leadingConstraint = nameLabel.trailingAnchor.constraint(
            equalTo: self.trailingAnchor,
            constant: -16
        )
        let heightConstraint = nameLabel.heightAnchor.constraint(equalToConstant: 18)
        let widthConstraint = nameLabel.widthAnchor.constraint(equalToConstant: 300)
        NSLayoutConstraint.activate([
            topConstraint,
            trailingConstraint,
            leadingConstraint,
            heightConstraint,
            widthConstraint
        ])
    }

    private func constraintsContentLabel() {
        let topConstraint = contentLabel.topAnchor.constraint(
            greaterThanOrEqualTo: nameLabel.bottomAnchor, constant: 0
        )
        let trailingConstraint = contentLabel.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: 16
        )
        let leadingConstraint = contentLabel.trailingAnchor.constraint(
            equalTo: self.trailingAnchor,
            constant: -16
        )
        let heightConstraint = contentLabel.heightAnchor.constraint(equalToConstant: 10)
        let widthConstraint = contentLabel.widthAnchor.constraint(equalToConstant: 326)
        NSLayoutConstraint.activate([
            topConstraint,
            trailingConstraint,
            leadingConstraint,
            heightConstraint,
            widthConstraint
        ])
    }

    private func constraintsPhoneLabel() {
        let topConstraint = phoneLabel.topAnchor.constraint(
            equalTo: contentLabel.bottomAnchor,
            constant: 15
        )
        let trailingConstraint = phoneLabel.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: 16
        )
        let leadingConstraint = phoneLabel.trailingAnchor.constraint(
            equalTo: self.trailingAnchor,
            constant: -16
        )
        let heightConstraint = phoneLabel.heightAnchor.constraint(equalToConstant: 20)
        let widthConstraint = phoneLabel.widthAnchor.constraint(equalToConstant: 90)
        NSLayoutConstraint.activate([
            topConstraint,
            trailingConstraint,
            leadingConstraint,
            heightConstraint,
            widthConstraint
        ])
    }

    private func constraintsSkillsLabel() {
        let topConstraint = skillsLabel.topAnchor.constraint(
            equalTo: phoneLabel.bottomAnchor,
            constant: 10
        )
        let trailingConstraint = skillsLabel.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: 16
        )
        let leadingConstraint = skillsLabel.trailingAnchor.constraint(
            equalTo: self.trailingAnchor,
            constant: -16
        )
        let bottomConstraint = skillsLabel.bottomAnchor.constraint(
            equalTo: self.bottomAnchor,
            constant: -10
        )
        let heightConstraint = skillsLabel.heightAnchor.constraint(equalToConstant: 15)
        let widthConstraint = skillsLabel.widthAnchor.constraint(equalToConstant: 68)
        NSLayoutConstraint.activate([
            topConstraint,
            trailingConstraint,
            leadingConstraint,
            bottomConstraint,
            heightConstraint,
            widthConstraint
        ])
    }
}
