//
//  ExcerciseOverviewCell.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 13/12/2021.
//

import UIKit

struct ExcerciseViewModel: Hashable {
    static func == (lhs: ExcerciseViewModel, rhs: ExcerciseViewModel) -> Bool {
        lhs.excercise == rhs.excercise && lhs.isFavorite == rhs.isFavorite
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(excercise)
    }

    let excercise: Excercise
    let isFavorite: Bool
    let onFavoriteChange: (Bool) -> Void
}

class ExcerciseOverviewCell: UITableViewCell, Reusable {
    private static let filledStar = UIImage(systemName: "star.fill")
    private static let star = UIImage(systemName: "star")
    private var viewModel: ExcerciseViewModel!

    let excerciseImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        return imgView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.contentMode = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemYellow
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(excerciseImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(favoriteButton)
        setupConstraints()
    }

    func configureCell(viewModel: ExcerciseViewModel) {
        self.viewModel = viewModel
        excerciseImage.load(url: viewModel.excercise.coverImageURL)
        nameLabel.text = viewModel.excercise.name
        favoriteButton.setImage(viewModel.isFavorite ? Self.filledStar : Self.star, for: .normal)
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("This view is not intended to be used with InterfaceBuilder")
    }

    @objc private func toggleFavorite() {
        viewModel.onFavoriteChange(!viewModel.isFavorite)
    }

    private func setupConstraints() {
        let excerciseImageBottomConstraint = excerciseImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        excerciseImageBottomConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            excerciseImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            excerciseImageBottomConstraint,
            excerciseImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            excerciseImage.widthAnchor.constraint(equalToConstant: 100),
            excerciseImage.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: excerciseImage.trailingAnchor, constant: Margin.standard),
            nameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -Margin.standard),
        ])
        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
