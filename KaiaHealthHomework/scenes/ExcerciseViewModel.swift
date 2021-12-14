//
//  ExcerciseViewModel.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 14/12/2021.
//

struct ExcerciseViewModel: Hashable {
    static func == (lhs: ExcerciseViewModel, rhs: ExcerciseViewModel) -> Bool {
        lhs.excercise == rhs.excercise && lhs.isFavorite == rhs.isFavorite
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(excercise)
    }

    let excercise: Excercise
    var isFavorite: Bool
    let onFavoriteChange: (Bool) -> Void
}
