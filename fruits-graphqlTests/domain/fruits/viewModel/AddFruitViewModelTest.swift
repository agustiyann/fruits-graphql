//
//  AddFruitViewModel.swift
//  fruits-graphqlTests
//
//  Created by Agus Tiyansyah Syam on 07/09/22.
//

import XCTest
import RxSwift
import Swinject
@testable import fruits_graphql

class AddFruitViewModelTest: XCTestCase {
    
    private var disposeBag: DisposeBag!
    private var fruitsUseCaseFactory: FruitsUseCaseFactory!
    private var addFruitViewModel: FruitInteractionViewModel!
    private var fruitInteractionSubject: FruitInteractionSubject!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        fruitsUseCaseFactory = FruitsUseCaseFactory()
        fruitInteractionSubject = Container.sharedContainer.resolve(FruitInteractionSubject.self)!
        addFruitViewModel = FruitInteractionViewModel(fruitsUseCase: fruitsUseCaseFactory.createInstance(), fruitInteractionSubject: fruitInteractionSubject)
    }
    
    override func tearDown() {
        super.tearDown()
        disposeBag = nil
        fruitsUseCaseFactory = nil
        addFruitViewModel = nil
    }
    
    func testAddFruitSuccess() {
        let resultExpectation = MockFruitModelData.generateSingleData()
        
        self.addFruitViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                XCTAssertNil(error)
            })
            .disposed(by: disposeBag)
        
        self.addFruitViewModel
            .fruitInteractionSubject
            .fruit
            .skip(1)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { fruit in
                XCTAssertEqual(fruit, resultExpectation)
            })
            .disposed(by: disposeBag)
        
        self.addFruitViewModel.addFruit(
            addFruitId: "",
            scientificName: "",
            treeName: "",
            fruitName: "",
            family: "",
            origin: "",
            description: "",
            bloom: "",
            maturationFruit: "",
            lifeCycle: "",
            climaticZone: "")
    }
    
    func testAddFruitFailed() {
        self.addFruitViewModel = FruitInteractionViewModel(fruitsUseCase: fruitsUseCaseFactory.createInstanceFailed(), fruitInteractionSubject: fruitInteractionSubject)
        
        self.addFruitViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                XCTAssertNotNil(error)
            })
            .disposed(by: disposeBag)
        
        self.addFruitViewModel.addFruit(
            addFruitId: "",
            scientificName: "",
            treeName: "",
            fruitName: "",
            family: "",
            origin: "",
            description: "",
            bloom: "",
            maturationFruit: "",
            lifeCycle: "",
            climaticZone: "")
    }

}
