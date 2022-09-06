//
//  FruitsRepositoryImpl.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import Foundation

class FruitsRepositoryImpl: FruitsRepository {
    
    static let shared: FruitsRepository = FruitsRepositoryImpl()
    private var apolloClient: ApolloNetwork
    
    init(apolloClient: ApolloNetwork = ApolloNetwork.shared) {
        self.apolloClient = apolloClient
    }
    
    func getFruits(completion: @escaping (Result<[FruitModel], Error>) -> Void) {
        self.apolloClient.apollo.fetch(query: FruitListQuery(), cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let response):
                if let data = response.data?.fruits {
                    let fruits = FruitMapper.shared.convertGraphqlFruitListToArrayFruitModel(fruits: data)
                    completion(.success(fruits))
                } else {
                    completion(.failure(BaseErrorModel.convertGraphqlError(errors: response.errors)))
                }
            case .failure(let error):
                completion(.failure(error.convertToBaseErrorModel()))
            }
        }
    }
}
