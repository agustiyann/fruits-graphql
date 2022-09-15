//
//  SwinjectStoryboard+Extension.swift
//  fruits-graphql
//
//  Created by agustiyan on 15/09/22.
//

import Foundation
import Swinject
import SwinjectStoryboard
 
extension SwinjectStoryboard {
    @objc class func setup() {
        
        // MARK: - View Controller
        defaultContainer.register(FruitsUseCase.self) { _ in
            FruitsUseCaseImpl.shared
        }
        defaultContainer.register(FruitInteractionSubject.self) { _ in
            FruitInteractionSubject.shared
        }
        defaultContainer.register(FruitsViewModel.self) { r in
            let fruitUseCase = r.resolve(FruitsUseCase.self)!
            let fruitInteraction = r.resolve(FruitInteractionSubject.self)!
            return FruitsViewModel(fruitsUseCase: fruitUseCase, fruitInteractionSubject: fruitInteraction)
        }
        defaultContainer.storyboardInitCompleted(ViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(FruitsViewModel.self)
        }
        
        // MARK: - Add Fruit View Controller
        defaultContainer.register(FruitInteractionViewModel.self) { r in
            let fruitUseCase = r.resolve(FruitsUseCase.self)!
            let fruitInteraction = r.resolve(FruitInteractionSubject.self)!
            return FruitInteractionViewModel(fruitsUseCase: fruitUseCase, fruitInteractionSubject: fruitInteraction)
        }
        
        defaultContainer.storyboardInitCompleted(AddFruitViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(FruitInteractionViewModel.self)
        }
    }
}
