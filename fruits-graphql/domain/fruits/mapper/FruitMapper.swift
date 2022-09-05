//
//  FruitsMapper.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import Foundation

class FruitMapper {
    static let shared = FruitMapper()
    
    func convertGraphqlFruitsToFruitsModel(fruit: FruitFragment) -> FruitModel {
        return FruitModel(id: fruit.id!, name: fruit.fruitName!, origin: fruit.origin!, description: fruit.description!)
    }
}
