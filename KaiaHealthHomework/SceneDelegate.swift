//
//  SceneDelegate.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 14/12/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let injectionContainer = MainDependencyContainer()

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let rootController = UINavigationController(rootViewController: injectionContainer.excerciseOverviewViewController)
        window.rootViewController = rootController
        self.window = window
        window.makeKeyAndVisible()
    }
}

