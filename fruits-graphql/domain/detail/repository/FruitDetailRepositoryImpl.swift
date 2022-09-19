//
//  FruitDetailRepositoryImpl.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 06/09/22.
//

import Foundation

final class FruitDetailRepositoryImpl: NSObject {
    
    private var apolloService: ApolloNetwork?
    
    init(apolloService: ApolloNetwork?) {
        self.apolloService = apolloService
    }
    
    static let shared: (ApolloNetwork?) -> FruitDetailRepository = { apolloService in
        return FruitDetailRepositoryImpl(apolloService: apolloService)
    }
}

extension FruitDetailRepositoryImpl: FruitDetailRepository {
    
    func getFruitDetail(
        id: String,
        completion: @escaping (Result<FruitDetailModel, Error>) -> Void
    ) {
        apolloService?.apollo.fetch(
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
