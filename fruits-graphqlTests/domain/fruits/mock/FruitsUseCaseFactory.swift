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
        return fruitsUseCase
    }
    
    func createInstanceFailed() -> FruitsUseCase {
        self.setupGetFruitsError()
        self.deleteFruitError()
        return fruitsUseCase
    }
    
    private func setupGetFruits() {
        given(self.fruitsUseCase.getFruits(completion: any())) ~> { completion in
            completion(.success([fruitModelMock]))
        }
    }
    
    private func setupGetFruitsError() {
        given(self.fruitsUseCase.getFruits(completion: any())) ~> { completion in
            completion(.failure(MockError.error))
        }
    }
    
    private func deleteFruitSuccess() {
        given(self.fruitsUseCase.deleteFruit(id: any(), completion: any())) ~> { id, completion in
            completion(.success(succesDelete))
        }
    }
    
    private func deleteFruitError() {
        given(self.fruitsUseCase.deleteFruit(id: any(), completion: any())) ~> { id, completion in
            completion(.failure(MockError.error))
        }
    }
    
}
