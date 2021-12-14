//
//  TrainingViewModel.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 14/12/2021.
//

protocol TrainingViewModel {
    var excercise: ExcerciseViewModel? { get }
    func goToNextExcercise()
    func toggleFavoriteStatus()
}

protocol FavoriteExcerciseChangedResponder: AnyObject {
    func favoriteExcerciseDidChange(_: Excercise, to: Bool)
}

class TrainingViewModelImpl: TrainingViewModel {
    private weak var favoriteExcerciseChangedResponder: FavoriteExcerciseChangedResponder?
    private(set) var excercises: [ExcerciseViewModel]
    private var currentExcerciseIndex = 0

    var excercise: ExcerciseViewModel? {
        guard currentExcerciseIndex < excercises.count else { return nil }
        return excercises[currentExcerciseIndex]
    }

    init(
        excercises: [ExcerciseViewModel],
        favoriteExcerciseChangedResponder: FavoriteExcerciseChangedResponder
    ) {
        self.excercises = excercises
        self.favoriteExcerciseChangedResponder = favoriteExcerciseChangedResponder
    }

    func goToNextExcercise() {
        currentExcerciseIndex += 1
    }

    func toggleFavoriteStatus() {
        guard let currentExcercise = excercise else { return }
        excercises[currentExcerciseIndex].isFavorite.toggle()
        favoriteExcerciseChangedResponder?.favoriteExcerciseDidChange(
            currentExcercise.excercise,
            to: excercises[currentExcerciseIndex].isFavorite
        )
    }
}
