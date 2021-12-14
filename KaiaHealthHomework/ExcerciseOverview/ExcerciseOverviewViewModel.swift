//
//  ExcerciseOverviewViewModel.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 14/12/2021.
//

import Foundation
import Combine

protocol ExcerciseOverviewViewModel {
    var excercises: [ExcerciseViewModel] { get }
    func updateFavoriteStatus(for: Excercise, to: Bool)
}

class MockExcerciseOverviewViewModel: ExcerciseOverviewViewModel {
    var onExcercisesUpdate: (() -> Void)?

    lazy var excercises = (0..<20).map { index in
        Excercise(
            id: index,
            name: "Excercise - \(index)",
            coverImageURL: URL(string: "https://d32oopmphic0po.cloudfront.net/v1/images/body/en-US/body-exercise-4-14.png")!,
            videoURL: URL(string: "https://d32oopmphic0po.cloudfront.net/v1/images/body/en-US/body-exercise-4-14.png")!
        )
    }.map { excercise in
        ExcerciseViewModel(
            excercise: excercise,
            isFavorite: false) { [unowned self] newValue in
                self.updateFavoriteStatus(for: excercise, to: newValue)
                onExcercisesUpdate?()
            }
    }

    func updateFavoriteStatus(for excercise: Excercise, to isFavorite: Bool) {
        guard let excerciseIndex = excercises.firstIndex(where: { $0.excercise == excercise }) else { return }
        excercises[excerciseIndex] = ExcerciseViewModel(
            excercise: excercise,
            isFavorite: isFavorite,
            onFavoriteChange: { [unowned self] newValue in
                self.updateFavoriteStatus(for: excercise, to: newValue)
                onExcercisesUpdate?()
            }
        )
    }
}
