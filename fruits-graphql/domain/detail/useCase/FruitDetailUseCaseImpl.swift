//
//  FruitDetailUseCaseImpl.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 06/09/22.
//

import Foundation

class FruitDetailUseCaseImpl: FruitDetailUseCase {
    
    static let shared = FruitDetailUseCaseImpl()
    private var fruitDetailRepository: FruitDetailRepository
    
    init(fruitDetailRepository: FruitDetailRepository = FruitDetailRepositoryImpl.shared) {
        self.fruitDetailRepository = fruitDetailRepository
    }
    
    func getFruitDetail(id: String, completion: @escaping (Result<FruitDetailModel, Error>) -> Void) {
        fruitDetailRepository.getFruitDetail(id: id, completion: completion)
    }
    
}
