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
    
    func addFruit(
        addFruitId: String,
        scientificName: String,
        treeName: String,
        fruitName: String,
        family: String,
        origin: String,
        description: String,
        bloom: String,
        maturationFruit: String,
        lifeCycle: String,
        climaticZone: String,
        completion: @escaping (Result<FruitModel, Error>) -> Void
    ) {
        apolloClient.apollo.perform(mutation: AddFruitMutation(
            addFruitId: addFruitId,
            scientificName: scientificName,
            treeName: treeName,
            fruitName: fruitName,
            family: family,
            origin: origin,
            description: description,
            bloom: bloom,
            maturationFruit: maturationFruit,
            lifeCycle: lifeCycle,
            climaticZone: climaticZone
        )) { result in
            switch result {
            case .success(let result):
                if let data = result.data?.addFruit {
                    let fragment = data.fragments.fruitFragment
                    let fruit = FruitMapper.shared.convertGraphqlFruitToFruitModel(fruit: fragment)
                    completion(.success(fruit))
                } else {
                    completion(.failure(BaseErrorModel.convertGraphqlError(errors: result.errors)))
                }
            case .failure(let error):
                completion(.failure(error.convertToBaseErrorModel()))
            }
        }
    }
}
