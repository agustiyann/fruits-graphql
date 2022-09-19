//
//  SceneDelegate.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window?.windowScene = windowScene

        let viewController = ViewController.instantiateFrom(storyboard: .fruit)
        viewController.viewModel = Injection.init().provideFruitsViewModel()
        let navViewController = UINavigationController(rootViewController: viewController)
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = navViewController
        window?.makeKeyAndVisible()
    }


}

