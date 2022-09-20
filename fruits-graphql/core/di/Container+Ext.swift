//
//  Container+Ext.swift
//  fruits-graphql
//
//  Created by agustiyan on 20/09/22.
//

import Foundation
import Swinject

extension Container {
    
    static let sharedContainer: Container = {
        let container = Container()
        
        container.register(FruitDetailUseCase.self) { _ in
            FruitDetailUseCaseImpl.shared
        }
        
        container.register(FruitDetailViewModel.self) { r in
            let useCase = r.resolve(FruitDetailUseCase.self)!
            return FruitDetailViewModel(fruitDetailUseCase: useCase)
        }
        
        container.register(DetailFruitXibViewController.self) { r in
            let detailVc = DetailFruitXibViewController()
            detailVc.viewModel = r.resolve(FruitDetailViewModel.self)
            return detailVc
        }
        
        return container
    }()
    
}
