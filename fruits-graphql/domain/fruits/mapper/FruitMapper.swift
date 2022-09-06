//
//  FruitsMapper.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import Foundation

class FruitMapper {
    static let shared = FruitMapper()
    
    func convertGraphqlFruitListToArrayFruitModel(fruits: [FruitListQuery.Data.Fruit?]) -> [FruitModel] {
        var fruitList = [FruitModel]()
        fruits.forEach { fruit in
            let fruitMap = FruitMapper.shared.convertGraphqlFruitToFruitModel(fruit: (fruit!.fragments.fruitFragment))
            fruitList.append(fruitMap)
        }
        
        return fruitList
    }
    
    func convertGraphqlFruitToFruitModel(fruit: FruitFragment) -> FruitModel {
        return FruitModel(id: fruit.id!, name: fruit.fruitName!)
    }
}
