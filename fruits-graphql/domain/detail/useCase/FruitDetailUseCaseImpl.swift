//
//  FruitDetailUseCaseImpl.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 06/09/22.
//

import Foundation

final class FruitDetailUseCaseImpl: NSObject {
    
    private var fruitDetailRepository: FruitDetailRepository?
    
    private init(fruitDetailRepository: FruitDetailRepository?) {
        self.fruitDetailRepository = fruitDetailRepository
    }
    
    static let shared: (FruitDetailRepository?) -> FruitDetailUseCaseImpl = { fruitDetailRepository in
        return FruitDetailUseCaseImpl(fruitDetailRepository: fruitDetailRepository)
    }
}

extension FruitDetailUseCaseImpl: FruitDetailUseCase {
    
    func getFruitDetail(id: String, completion: @escaping (Result<FruitDetailModel, Error>) -> Void) {
        fruitDetailRepository?.getFruitDetail(id: id, completion: completion)
    }
    
}
