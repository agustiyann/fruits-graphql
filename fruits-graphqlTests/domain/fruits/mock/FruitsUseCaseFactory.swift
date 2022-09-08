//
//  FruitsUseCaseFactory.swift
//  fruits-graphqlTests
//
//  Created by Agus Tiyansyah Syam on 07/09/22.
//

import Foundation
import Mockingbird
@testable import fruits_graphql

class FruitsUseCaseFactory {
    private let fruitsUseCase = mock(FruitsUseCase.self)
    
    func createInstance() -> FruitsUseCase {
        self.setupGetFruits()
        self.deleteFruitSuccess()
        self.addFruitSuccess()
        return fruitsUseCase
    }
    
    func createInstanceFailed() -> FruitsUseCase {
        self.setupGetFruitsError()
        self.deleteFruitError()
        self.addFruitError()
        return fruitsUseCase
    }
    
    private func setupGetFruits() {
        given(self.fruitsUseCase.getFruits(completion: any())) ~> { completion in
            completion(.success(MockFruitModelData.generateListData()))
        }
    }
    
    private func setupGetFruitsError() {
        given(self.fruitsUseCase.getFruits(completion: any())) ~> { completion in
            completion(.failure(MockError.error))
        }
    }
    
    private func deleteFruitSuccess() {
        given(self.fruitsUseCase.deleteFruit(id: any(), completion: any())) ~> { id, completion in
            completion(.success(MockStringMessage.succesDelete))
        }
    }
    
    private func deleteFruitError() {
        given(self.fruitsUseCase.deleteFruit(id: any(), completion: any())) ~> { id, completion in
            completion(.failure(MockError.error))
        }
    }
    
    private func addFruitSuccess() {
        given(self.fruitsUseCase.addFruit(
            addFruitId: any(),
            scientificName: any(),
            treeName: any(),
            fruitName: any(),
            family: any(),
            origin: any(),
            description: any(),
            bloom: any(),
            maturationFruit: any(),
            lifeCycle: any(),
            climaticZone: any(),
            completion: any())
        ) ~> { id, scName, tName, fName, family, origin, desc, bloom, maturation, lifeCycle, climatic, completion in
            completion(.success(MockFruitModelData.generateSingleData()))
        }
    }
    
    private func addFruitError() {
        given(self.fruitsUseCase.addFruit(
            addFruitId: any(),
            scientificName: any(),
            treeName: any(),
            fruitName: any(),
            family: any(),
            origin: any(),
            description: any(),
            bloom: any(),
            maturationFruit: any(),
            lifeCycle: any(),
            climaticZone: any(),
            completion: any())
        ) ~> { id, scName, tName, fName, family, origin, desc, bloom, maturation, lifeCycle, climatic, completion in
            completion(.failure(MockError.error))
        }
    }
    
}
