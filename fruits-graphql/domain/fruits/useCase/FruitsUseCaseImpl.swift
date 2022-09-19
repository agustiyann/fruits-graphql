//
//  FruitsUseCaseImpl.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import Foundation

final class FruitsUseCaseImpl: NSObject {
    
    private var fruitsRepository: FruitsRepository?
    
    private init(fruitsRepository: FruitsRepository?) {
        self.fruitsRepository = fruitsRepository
    }
    
    static let shared: (FruitsRepository?) -> FruitsUseCaseImpl = { fruitsRepository in
        return FruitsUseCaseImpl(fruitsRepository: fruitsRepository)
    }
}

extension FruitsUseCaseImpl: FruitsUseCase {
    
    func getFruits(completion: @escaping (Result<[FruitModel], Error>) -> Void) {
        self.fruitsRepository?.getFruits(completion: completion)
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
        self.fruitsRepository?.addFruit(
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
            climaticZone: climaticZone,
            completion: completion)
    }
    
    func deleteFruit(id: String, completion: @escaping (Result<String, Error>) -> Void) {
        self.fruitsRepository?.deleteFruit(id: id, completion: completion)
    }
}
