//
//  FruitDetailRepositoryImpl.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 06/09/22.
//

import Foundation

class FruitDetailRepositoryImpl: FruitDetailRepository {
    
    static let shared = FruitDetailRepositoryImpl()
    private var apolloService: ApolloNetwork
    
    init(apolloService: ApolloNetwork = ApolloNetwork.shared) {
        self.apolloService = apolloService
    }
    
    func getFruitDetail(
        id: String,
        completion: @escaping (Result<FruitDetailModel, Error>) -> Void
    ) {
        apolloService.apollo.fetch(
            query: FruitDetailQuery(fruitId: id),
            cachePolicy: .fetchIgnoringCacheData
        ) { result in
            switch result {
            case .success(let result):
                if let data = result.data?.fruit {
                    let fruitDetail = FruitDetailMapper.shared.convertGraphqlFruitDetailToFruitDetailModel(fruit: data)
                    completion(.success(fruitDetail))
                } else {
                    completion(.failure(BaseErrorModel.convertGraphqlError(errors: result.errors)))
                }
            case .failure(let error):
                completion(.failure(error.convertToBaseErrorModel()))
            }
        }
    }
}
