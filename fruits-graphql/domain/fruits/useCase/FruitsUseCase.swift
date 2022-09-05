//
//  FruitsUseCase.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import Foundation

protocol FruitsUseCase {
    func getFruits(completion: @escaping (Result<[FruitModel], Error>) -> Void)
}
