//
//  FruitsUseCaseImpl.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import Foundation

class FruitsUseCaseImpl: FruitsUseCase {
    
    static let shared: FruitsUseCase = FruitsUseCaseImpl()
    private var fruitsRepository: FruitsRepository
    
    init(fruitsRepository: FruitsRepository = FruitsRepositoryImpl.shared) {
        self.fruitsRepository = fruitsRepository
    }
    
    func getFruits(completion: @escaping (Result<[FruitModel], Error>) -> Void) {
        self.fruitsRepository.getFruits(completion: completion)
    }
}
