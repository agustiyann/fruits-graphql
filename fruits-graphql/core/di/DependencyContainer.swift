//
//  DependencyContainer.swift
//  fruits-graphql
//
//  Created by agustiyan on 16/09/22.
//

import Foundation
import DIKit

public extension DependencyContainer {
    static var fruitUseCase = module {
        single {
            FruitsUseCaseImpl.shared as FruitsUseCase
        }
    }
    
    static var fruitInteractionSubject = module {
        single {
            FruitInteractionSubject.shared as FruitInteractionSubject
        }
    }
    
    static var fruitViewModel = module {
        single {
            FruitsViewModel() as FruitsViewModel
        }
    }
    
    static var fruitInteractionViewModel = module {
        single {
            FruitInteractionViewModel() as FruitInteractionViewModel
        }
    }
    
    static var fruitDetailUseCase = module {
        single {
            FruitDetailUseCaseImpl.shared as FruitDetailUseCase
        }
    }
    
    static var fruitDetailViewModel = module {
        single {
            FruitDetailViewModel() as FruitDetailViewModel
        }
    }
}
