//
//  FruitDetailUseCase.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 06/09/22.
//

import Foundation

protocol FruitDetailUseCase {
    func getFruitDetail(id: String, completion: @escaping (Result<FruitDetailModel, Error>) -> Void)
}
