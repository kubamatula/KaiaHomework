//
//  TrainingViewController.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 14/12/2021.
//

import UIKit

class TrainingViewController: UIViewController {

    private let viewModel: TrainingViewModel

    let excerciseImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        return imgView
    }()

    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.contentMode = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemYellow
        button.addTarget(self, action: #selector(tapFavorite), for: .touchUpInside)
        return button
    }()

    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel training", for: .normal)
        button.addTarget(self, action: #selector(cancelTraining), for: .touchUpInside)
        return button
    }()

    init(viewModel: TrainingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("This view is not intended to be used with InterfaceBuilder")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCurrentExcerciseOrFinish()
    }

    private func setupCurrentExcerciseOrFinish() {
        guard let excercise = viewModel.excercise else {
            cancelTraining()
            return
        }
        excerciseImage.load(url: excercise.excercise.coverImageUrl)
        refreshFavoriteButton()
    }

    private func refreshFavoriteButton() {
        guard let excercise = viewModel.excercise else {
            return
        }
        favoriteButton.setImage(FavoriteImage.image(excercise.isFavorite), for: .normal)
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(excerciseImage)
        view.addSubview(favoriteButton)
        view.addSubview(cancelButton)

        NSLayoutConstraint.activate([
            excerciseImage.topAnchor.constraint(equalTo: view.topAnchor),
            excerciseImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            excerciseImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            excerciseImage.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        NSLayoutConstraint.activate([
            cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Margin.standard),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin.standard),
        ])
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: cancelButton.trailingAnchor),
            favoriteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Margin.standard),
        ])
    }

    @objc private func cancelTraining() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func tapFavorite() {
        viewModel.toggleFavoriteStatus()
        refreshFavoriteButton()
    }
}
