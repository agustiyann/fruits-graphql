//
//  FruitsViewModelTest.swift
//  fruits-graphqlTests
//
//  Created by Agus Tiyansyah Syam on 07/09/22.
//

import XCTest
import RxSwift
@testable import fruits_graphql

class FruitsViewModelTest: XCTestCase {
    private var disposeBag: DisposeBag!
    private var fruitsUseCaseFactory: FruitsUseCaseFactory!
    private var fruitsViewModel: FruitsViewModel!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        fruitsUseCaseFactory = FruitsUseCaseFactory()
        fruitsViewModel = FruitsViewModel(fruitsUseCase: fruitsUseCaseFactory.createInstance())
    }
    
    override func tearDown() {
        super.tearDown()
        disposeBag = nil
        fruitsUseCaseFactory = nil
        fruitsViewModel = nil
    }
    
    func testGetFruitsSuccess() {
        let expectation = expectation(description: "Should return List FruitModel")
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
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        self.fruitsViewModel.getFruits()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGetFruitsFailed() {
        self.fruitsViewModel = FruitsViewModel(fruitsUseCase: fruitsUseCaseFactory.createInstanceFailed())
        let expectation = expectation(description: "Should return Error")
        
        self.fruitsViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        self.fruitsViewModel.getFruits()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testDeleteSuccess() {
        self.fruitsViewModel = FruitsViewModel(fruitsUseCase: fruitsUseCaseFactory.createInstance())
        let expectation = expectation(description: "Should return String: Success message")
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
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        self.fruitsViewModel.deleteFruit(id: "1")
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testDeleteFailed() {
        self.fruitsViewModel = FruitsViewModel(fruitsUseCase: fruitsUseCaseFactory.createInstanceFailed())
        let expectation = expectation(description: "Should return Error")
        
        self.fruitsViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        self.fruitsViewModel.deleteFruit(id: "1")
        waitForExpectations(timeout: 1, handler: nil)
    }

}
