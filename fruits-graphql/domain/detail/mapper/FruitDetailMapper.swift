//
//  FruitDetailMapper.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 06/09/22.
//

import Foundation

class FruitDetailMapper {
    static let shared = FruitDetailMapper()
    
    func convertGraphqlFruitDetailToFruitDetailModel(fruit: FruitDetailQuery.Data.Fruit) -> FruitDetailModel {
        return FruitDetailModel(id: fruit.id!, name: fruit.fruitName!, origin: fruit.origin!, description: fruit.description!)
    }
}
