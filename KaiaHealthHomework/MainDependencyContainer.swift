//
//  MainDependencyContainer.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 14/12/2021.
//

import UIKit

public class MainDependencyContainer {

    let jsonDecoder: JSONDecoder
    let excerciseRepository: ExcerciseRepository
    let favoriteExcerciseStore: FavoriteExcerciseStore

    private(set) lazy var excerciseOverviewViewController = ExcerciseOverviewViewController(
        viewModel: excerciseOverviewViewModel,
        trainingViewControllerFactory: { [unowned self] in self.makeTrainingViewController(excercises: $0) }
    )

    private(set) lazy var excerciseOverviewViewModel: ExcerciseOverviewViewModel = ExcerciseOverviewViewModelImpl(
        excerciseRepository: excerciseRepository,
        favoriteExcerciseStore: favoriteExcerciseStore
    )

    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonDecoder = decoder
        self.excerciseRepository = RemoteExcerciseRepository(session: .shared, decoder: decoder)
        self.favoriteExcerciseStore = UserDefaultsFavoriteExcerciseStore()
    }

    func makeTrainingViewController(excercises: [ExcerciseViewModel]) -> TrainingViewController {
        let viewModel = makeTrainingViewControllerViewModel(excercises: excercises)
        return TrainingViewController(viewModel: viewModel)
    }

    func makeTrainingViewControllerViewModel(excercises: [ExcerciseViewModel]) -> TrainingViewModel {
        TrainingViewModelImpl(
            excercises: excercises,
            favoriteExcerciseChangedResponder: excerciseOverviewViewModel
        )
    }
}
