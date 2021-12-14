//
//  ExcerciseOverviewViewModel.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 14/12/2021.
//

import Foundation

protocol ExcerciseOverviewViewModel {
    var excercises: [Excercise] { get }
}

class MockExcerciseOverviewViewModel: ExcerciseOverviewViewModel {
    let excercises = (0..<20).map { index in
        Excercise(
            id: index,
            name: "Excercise - \(index)",
            coverImageURL: URL(string: "https://d32oopmphic0po.cloudfront.net/v1/images/body/en-US/body-exercise-4-14.png")!,
            videoURL: URL(string: "https://d32oopmphic0po.cloudfront.net/v1/images/body/en-US/body-exercise-4-14.png")!
        )
    }
}
