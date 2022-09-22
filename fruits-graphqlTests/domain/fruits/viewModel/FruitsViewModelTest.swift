//
//  FruitsViewModelTest.swift
//  fruits-graphqlTests
//
//  Created by Agus Tiyansyah Syam on 07/09/22.
//

import XCTest
import RxSwift
import Swinject
@testable import fruits_graphql

class FruitsViewModelTest: XCTestCase {
    private var disposeBag: DisposeBag!
    private var fruitsUseCaseFactory: FruitsUseCaseFactory!
    private var fruitsViewModel: FruitsViewModel!
    private var fruitInteractionSubject: FruitInteractionSubject!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        fruitsUseCaseFactory = FruitsUseCaseFactory()
        fruitInteractionSubject = Container.sharedContainer.resolve(FruitInteractionSubject.self)!
        fruitsViewModel = FruitsViewModel(fruitsUseCase: fruitsUseCaseFactory.createInstance(), fruitInteractionSubject: fruitInteractionSubject)
    }
    
    override func tearDown() {
        super.tearDown()
        disposeBag = nil
        fruitsUseCaseFactory = nil
        fruitsViewModel = nil
    }
    
    func testGetFruitsSuccess() {
        let resultExpectation = MockFruitModelData.generateListData()
        
        self.fruitsViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                XCTAssertNil(error)
            })
            .disposed(by: disposeBag)
        
        self.fruitsViewModel
            .fruits
            .skip(1)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { fruits in
                XCTAssertEqual(fruits, resultExpectation)
                XCTAssertEqual(fruits.count, 2)
                XCTAssertEqual(fruits.first?.id, resultExpectation[0].id)
            })
            .disposed(by: disposeBag)
        
        self.fruitsViewModel.getFruits()
    }
    
    func testGetFruitsFailed() {
        self.fruitsViewModel = FruitsViewModel(fruitsUseCase: fruitsUseCaseFactory.createInstanceFailed(), fruitInteractionSubject: fruitInteractionSubject)
        
        self.fruitsViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                XCTAssertNotNil(error)
            })
            .disposed(by: disposeBag)
        
        self.fruitsViewModel.getFruits()
    }
    
    func testDeleteSuccess() {
        self.fruitsViewModel = FruitsViewModel(fruitsUseCase: fruitsUseCaseFactory.createInstance(), fruitInteractionSubject: fruitInteractionSubject)
        let resultExpectation = MockStringMessage.succesDelete
        
        self.fruitsViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                XCTAssertNil(error)
            })
            .disposed(by: disposeBag)
        
        self.fruitsViewModel
            .success
            .skip(1)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { message in
                XCTAssertEqual(message, resultExpectation)
            })
            .disposed(by: disposeBag)
        
        self.fruitsViewModel.deleteFruit(id: "1")
    }
    
    func testDeleteFailed() {
        self.fruitsViewModel = FruitsViewModel(fruitsUseCase: fruitsUseCaseFactory.createInstanceFailed(), fruitInteractionSubject: fruitInteractionSubject)
        
        self.fruitsViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                XCTAssertNotNil(error)
            })
            .disposed(by: disposeBag)
        
        self.fruitsViewModel.deleteFruit(id: "1")
    }

}
