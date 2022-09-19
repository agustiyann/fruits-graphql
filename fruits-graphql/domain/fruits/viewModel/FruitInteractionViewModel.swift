//
//  AddFruitViewModel.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 06/09/22.
//

import Foundation
import RxSwift

class FruitInteractionSubject {
    static let shared = FruitInteractionSubject()
    var fruit: PublishSubject<FruitModel> = PublishSubject()
}

class FruitInteractionViewModel {
    
    private var fruitsUseCase: FruitsUseCase
    var error: PublishSubject<Error?> = PublishSubject()
    var loading: PublishSubject<Bool> = PublishSubject()
    var fruitInteractionSubject: FruitInteractionSubject
    
    init(fruitsUseCase: FruitsUseCase = Injection.init().provideFruits(),
         fruitInteractionSubject: FruitInteractionSubject = FruitInteractionSubject.shared) {
        self.fruitsUseCase = fruitsUseCase
        self.fruitInteractionSubject = fruitInteractionSubject
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
                self?.fruitInteractionSubject.fruit.onNext(fruit)
            case .failure(let error):
                self?.error.onNext(error)
            }
            self?.loading.onNext(false)
        }
    }
    
}
