//
//  FruitsHelper.swift
//  fruits-graphqlTests
//
//  Created by Agus Tiyansyah Syam on 07/09/22.
//

import Foundation
@testable import fruits_graphql


struct MockFruitModelData {
    static func generateSingleData() -> FruitModel {
        return FruitModel(id: "1", name: "Aple")
    }
    
    static func generateListData() -> [FruitModel] {
        return [FruitModel(id: "1", name: "Apple"),
                FruitModel(id: "2", name: "Orange")]
    }
}

struct MockStringMessage {
    static let succesDelete = "Fruit success deleted"
}
