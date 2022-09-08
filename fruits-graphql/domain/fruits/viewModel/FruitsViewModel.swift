//
//  FruitsViewModel.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import Foundation
import RxSwift

class FruitInteractionSubject {
    static let shared = FruitInteractionSubject()
    var fruits: PublishSubject<[FruitModel]> = PublishSubject()
}

class FruitsViewModel {
    
    private var fruitsUseCase: FruitsUseCase
    var success: BehaviorSubject<String> = BehaviorSubject(value: "")
    var error: PublishSubject<Error?> = PublishSubject()
    var loading: PublishSubject<Bool> = PublishSubject()
    var fruitInteractionSubject: FruitInteractionSubject
    
    init(fruitsUseCase: FruitsUseCase = FruitsUseCaseImpl.shared,
         fruitInteractionSubject: FruitInteractionSubject = FruitInteractionSubject.shared) {
        self.fruitsUseCase = fruitsUseCase
        self.fruitInteractionSubject = fruitInteractionSubject
    }
    
    func getFruits() {
        self.loading.onNext(true)
        self.fruitsUseCase.getFruits { result in
            switch result {
            case .success(let response):
                self.error.onNext(nil)
                self.fruitInteractionSubject.fruits.onNext(response)
            case .failure(let error):
                self.error.onNext(error)
            }
            self.loading.onNext(false)
        }
    }
    
    func deleteFruit(id: String) {
        self.loading.onNext(true)
        self.fruitsUseCase.deleteFruit(id: id) { result in
            switch result {
            case .success(let response):
                self.error.onNext(nil)
                self.success.onNext(response)
            case .failure(let error):
                self.error.onNext(error)
            }
            self.loading.onNext(false)
        }
    }
    
}
