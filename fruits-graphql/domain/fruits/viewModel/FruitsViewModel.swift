//
//  FruitsViewModel.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import Foundation
import RxSwift
import DIKit

class FruitsViewModel {
    
    private var fruitsUseCase: FruitsUseCase
    var fruits: BehaviorSubject<[FruitModel]> = BehaviorSubject(value: [])
    var success: BehaviorSubject<String> = BehaviorSubject(value: "")
    var error: PublishSubject<Error?> = PublishSubject()
    var loading: PublishSubject<Bool> = PublishSubject()
    var fruitInteractionSubject: FruitInteractionSubject
    var disposeBag = DisposeBag()
    
    init(fruitsUseCase: FruitsUseCase = resolve(),
         fruitInteractionSubject: FruitInteractionSubject = resolve()) {
        self.fruitsUseCase = fruitsUseCase
        self.fruitInteractionSubject = fruitInteractionSubject
        self.observeFruitInteractionBinding()
    }
    
    func observeFruitInteractionBinding() {
        self.fruitInteractionSubject
            .fruit
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { fruitModel in
                let fruitMap = FruitMapper.shared.setUpdateFruit(currentFruits: self.fruits, addedFruit: fruitModel)
                if let fruitMap = fruitMap {
                    self.fruits.onNext(fruitMap)
                }
            })
            .disposed(by: disposeBag)
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
