//
//  TrainingViewModel.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 14/12/2021.
//

protocol TrainingViewModel {
    var excercises: [ExcerciseViewModel] { get }
    func updateFavoriteStatus(for: Excercise, to: Bool)
}

protocol FavoriteExcerciseChangedResponder: AnyObject {
    func favoriteExcerciseDidChange(_: Excercise, to: Bool)
}

class TrainingViewModelImpl: TrainingViewModel {
    private weak var favoriteExcerciseChangedResponder: FavoriteExcerciseChangedResponder?
    private(set) var excercises: [ExcerciseViewModel]

    init(
        excercises: [ExcerciseViewModel],
        favoriteExcerciseChangedResponder: FavoriteExcerciseChangedResponder
    ) {
        self.excercises = excercises
        self.favoriteExcerciseChangedResponder = favoriteExcerciseChangedResponder
    }

    func updateFavoriteStatus(for excercise: Excercise, to isFavorite: Bool) {
        guard let excerciseIndex = excercises.firstIndex(where: { $0.excercise == excercise }) else { return }
        excercises[excerciseIndex].isFavorite = isFavorite
        favoriteExcerciseChangedResponder?.favoriteExcerciseDidChange(excercise, to: isFavorite)
    }
}
