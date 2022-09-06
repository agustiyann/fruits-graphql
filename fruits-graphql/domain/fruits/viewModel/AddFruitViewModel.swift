//
//  AddFruitViewModel.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 06/09/22.
//

import Foundation
import RxSwift

class AddFruitViewModel {
    
    private var fruitsUseCase: FruitsUseCase
    var fruit: BehaviorSubject<FruitModel?> = BehaviorSubject(value: nil)
    var error: PublishSubject<Error?> = PublishSubject()
    var loading: PublishSubject<Bool> = PublishSubject()
    
    init(fruitsUseCase: FruitsUseCase = FruitsUseCaseImpl.shared) {
        self.fruitsUseCase = fruitsUseCase
    }
    
    func addFruit(
        addFruitId: String,
        scientificName: String,
        treeName: String,
        fruitName: String,
        family: String,
        origin: String,
        description: String,
        bloom: String,
        maturationFruit: String,
        lifeCycle: String,
        climaticZone: String
    ) {
        self.loading.onNext(true)
        fruitsUseCase.addFruit(
            addFruitId: addFruitId,
            scientificName: scientificName,
            treeName: treeName,
            fruitName: fruitName,
            family: family,
            origin: origin,
            description: description,
            bloom: bloom,
            maturationFruit: maturationFruit,
            lifeCycle: lifeCycle,
            climaticZone: climaticZone
        ) { [weak self] result in
            switch result {
            case .success(let fruit):
                self?.fruit.onNext(fruit)
            case .failure(let error):
                self?.error.onNext(error)
            }
            self?.loading.onNext(false)
        }
    }
    
}
