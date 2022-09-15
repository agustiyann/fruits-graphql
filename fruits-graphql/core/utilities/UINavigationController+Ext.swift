//
//  UINavigationController+Ext.swift
//  fruits-graphql
//
//  Created by agustiyan on 15/09/22.
//

import Foundation
import UIKit

extension UINavigationController {
    var previousViewController: UIViewController? { viewControllers.last { $0 != topViewController } }
    
    static func dismissViewController() {
        let navigationController = UIApplication.shared.keyWindow!.rootViewController as! UINavigationController
        navigationController.dismiss(animated: true)
    }
    
    static func replaceRootViewContoller(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping (Bool) -> Void = { _ in }
    ) {
        let window = UIApplication.shared.keyWindow!
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        if animated {
            UIView.transition(
                with: window,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: nil,
                completion: completion
            )
        }
    }

    static func pushToRootViewController(_ viewController: UIViewController, animated: Bool) {
        let navigationController = UIApplication.shared.keyWindow!.rootViewController as! UINavigationController
        navigationController.pushViewController(viewController, animated: animated)
    }
}
