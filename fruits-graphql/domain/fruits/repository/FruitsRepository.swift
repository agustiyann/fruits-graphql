//
//  FruitsRepository.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import Foundation

protocol FruitsRepository {
    func getFruits(completion: @escaping (Result<[FruitModel], Error>) -> Void)
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
        completion: @escaping (Result<FruitModel, Error>
        ) -> Void)
}
