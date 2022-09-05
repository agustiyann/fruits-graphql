//
//  FruitsViewModel.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import Foundation
import RxSwift

class FruitsViewModel {
    
    private var fruitsUseCase: FruitsUseCase
    var fruits: BehaviorSubject<[FruitModel]> = BehaviorSubject(value: [])
    var error: PublishSubject<Error?> = PublishSubject()
    var loading: PublishSubject<Bool> = PublishSubject()
    
    init(fruitsUseCase: FruitsUseCase = FruitsUseCaseImpl.shared) {
        self.fruitsUseCase = fruitsUseCase
    }
    
    func getFruits() {
        self.loading.onNext(true)
        self.fruitsUseCase.getFruits { result in
            switch result {
            case .success(let response):
                self.error.onNext(nil)
                self.fruits.onNext(response)
            case .failure(let error):
                self.error.onNext(error)
            }
            self.loading.onNext(false)
        }
    }
    
}
