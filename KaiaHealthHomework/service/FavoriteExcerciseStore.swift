//
//  FavoriteExcerciseStore.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 14/12/2021.
//

import Foundation

protocol FavoriteExcerciseStore {
    var favoriteExcerciseIds: Set<Int> { get }
    func saveFavoriteExcerciseIds(excerciseIds: [Int])
}

class UserDefaultsFavoriteExcerciseStore: FavoriteExcerciseStore {
    private static let favoriteExcercisesKey = "favoriteExcercisesKey"
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    var favoriteExcerciseIds: Set<Int> {
        let storedIds = userDefaults.array(forKey: Self.favoriteExcercisesKey) as? [Int]
        return Set(storedIds ?? [])
    }

    func saveFavoriteExcerciseIds(excerciseIds: [Int]) {
        userDefaults.set(excerciseIds, forKey: Self.favoriteExcercisesKey)
    }
}

