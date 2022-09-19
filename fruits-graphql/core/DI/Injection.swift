//
//  Injection.swift
//  fruits-graphql
//
//  Created by agustiyan on 19/09/22.
//

import Foundation

final class Injection: NSObject {
    
    private func provideFruitsRepository() -> FruitsRepository {
        let apolloClient: ApolloNetwork = ApolloNetwork.shared
        
        return FruitsRepositoryImpl.shared(apolloClient)
    }
    
    func provideFruits() -> FruitsUseCase {
        let repository = provideFruitsRepository()
        return FruitsUseCaseImpl.shared(repository)
    }
    
    func provideFruitsViewModel() -> FruitsViewModel {
        let fruitsUseCase = provideFruits()
        let fruitInteraction = FruitInteractionSubject.shared
        
        return FruitsViewModel(fruitsUseCase: fruitsUseCase, fruitInteractionSubject: fruitInteraction)
    }
    
    func provideFruitInteractionViewModel() -> FruitInteractionViewModel {
        let fruitUseCase = provideFruits()
        let fruitInteraction = FruitInteractionSubject.shared
        
        return FruitInteractionViewModel(fruitsUseCase: fruitUseCase, fruitInteractionSubject: fruitInteraction)
    }
    
    func provideDetailFruitRepository() -> FruitDetailRepository {
        let apolloClient: ApolloNetwork = ApolloNetwork.shared
        
        return FruitDetailRepositoryImpl.shared(apolloClient)
    }
    
    func provideFruitDetailUseCase() -> FruitDetailUseCase {
        let fruitDetailRepository = provideDetailFruitRepository()
        return FruitDetailUseCaseImpl.shared(fruitDetailRepository)
    }
    
    func provideDetailFruitViewModel() -> FruitDetailViewModel {
        let detailUseCase = provideFruitDetailUseCase()
        return FruitDetailViewModel(fruitDetailUseCase: detailUseCase)
    }
    
}
