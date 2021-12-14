//
//  ExcerciseOverviewViewModel.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 14/12/2021.
//

import Foundation
import Combine

protocol ExcerciseOverviewViewModel: FavoriteExcerciseChangedResponder {
    var excercises: [ExcerciseViewModel] { get }
    func updateFavoriteStatus(for: Excercise, to: Bool)
    func loadExcercises(completion: @escaping () -> Void)
}

class ExcerciseOverviewViewModelImpl: ExcerciseOverviewViewModel {
    var onExcercisesUpdate: (() -> Void)?
    private let excerciseRepository: ExcerciseRepository
    private let favoriteExcerciseStore: FavoriteExcerciseStore

    init(excerciseRepository: ExcerciseRepository, favoriteExcerciseStore: FavoriteExcerciseStore) {
        self.excerciseRepository = excerciseRepository
        self.favoriteExcerciseStore = favoriteExcerciseStore
    }

    private(set) var excercises: [ExcerciseViewModel] = []

    func loadExcercises(completion: @escaping () -> Void) {
        Task {
            do {
                let excercises = try await excerciseRepository.fetchExcercises()
                let favorites = favoriteExcerciseStore.favoriteExcerciseIds
                self.excercises = excercises.map {
                    makeExcerciseViewModel(excercise: $0, isFavorite: favorites.contains($0.id))
                }
                completion()
            } catch {
                print("Problem loading excercises: \(error)")
            }
        }
    }

    func updateFavoriteStatus(for excercise: Excercise, to isFavorite: Bool) {
        guard let excerciseIndex = excercises.firstIndex(where: { $0.excercise == excercise }) else { return }
        excercises[excerciseIndex] = makeExcerciseViewModel(excercise: excercise, isFavorite: isFavorite)
        let favoriteExcerciseIds = excercises.filter(\.isFavorite).map(\.excercise.id)
        favoriteExcerciseStore.saveFavoriteExcerciseIds(excerciseIds: favoriteExcerciseIds)
    }

    func favoriteExcerciseDidChange(_ excercise: Excercise, to isFavorite: Bool) {
        updateFavoriteStatus(for: excercise, to: isFavorite)
        onExcercisesUpdate?()
    }

    private func makeExcerciseViewModel(excercise: Excercise, isFavorite: Bool) -> ExcerciseViewModel {
        ExcerciseViewModel(
            excercise: excercise,
            isFavorite: isFavorite,
            onFavoriteChange: { [unowned self] newValue in
                self.updateFavoriteStatus(for: excercise, to: newValue)
                onExcercisesUpdate?()
            }
        )
    }
}
