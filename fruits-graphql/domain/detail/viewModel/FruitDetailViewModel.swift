//
//  FruitDetailViewModel.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 06/09/22.
//

import Foundation
import RxSwift

class FruitDetailViewModel {
    
    private let fruitDetailUseCase: FruitDetailUseCase
    var fruit: BehaviorSubject<FruitDetailModel?> = BehaviorSubject(value: nil)
    var error: PublishSubject<Error?> = PublishSubject()
    var loading: PublishSubject<Bool> = PublishSubject()
    
    private let disposeBag = DisposeBag()
    
    init(fruitDetailUseCase: FruitDetailUseCase) {
        self.fruitDetailUseCase = fruitDetailUseCase
    }
    
    func getFruitByID(id: String) {
        loading.onNext(true)
        fruitDetailUseCase.getFruitDetail(id: id) { [weak self] result in
            switch result {
            case .success(let response):
                self?.fruit.onNext(response)
            case .failure(let error):
                self?.error.onNext(error)
            }
            self?.loading.onNext(false)
        }
    }
    
}
