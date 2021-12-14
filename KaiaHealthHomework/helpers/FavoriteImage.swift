//
//  FavoriteImage.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 14/12/2021.
//

import UIKit

enum FavoriteImage {
    private static let filledStar = UIImage(systemName: "star.fill")!
    private static let star = UIImage(systemName: "star")!

    static func image(_ isFavorite: Bool) -> UIImage {
        isFavorite ? Self.filledStar : Self.star
    }
}
