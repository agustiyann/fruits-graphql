//
//  DetailFruitXibViewController.swift
//  fruits-graphql
//
//  Created by agustiyan on 20/09/22.
//

import UIKit
import RxSwift

class DetailFruitXibViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let origin: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.numberOfLines = 0
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var viewModel: FruitDetailViewModel?
    var id: String = ""
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindViewModel()
        viewModel?.getFruitByID(id: id)
    }
    
    private func bindViewModel() {
        viewModel?
            .fruit
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] fruit in
                self.title = fruit?.name
                self.origin.text = fruit?.origin
                self.descLabel.text = fruit?.description
            })
            .disposed(by: disposeBag)
        
        viewModel?
            .loading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { loading in
                loading ? print("loading") : print("finish")
            })
            .disposed(by: disposeBag)
        
        viewModel?
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                if error != nil {
                    guard let err = (error as? BaseErrorModel),
                            let message = err.errors.first?.message
                    else {
                        print("error system")
                        return
                    }
                    
                    print(message)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func configureUI() {
        self.view.addSubview(scrollView)
        let safeG = view.safeAreaLayoutGuide
        
        scrollView.leadingAnchor.constraint(equalTo: safeG.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeG.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeG.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeG.bottomAnchor).isActive = true
        
        scrollView.addSubview(descLabel)
        scrollView.addSubview(origin)
        
        origin.topAnchor.constraint(equalTo: safeG.topAnchor, constant: 10).isActive = true
        origin.leadingAnchor.constraint(equalTo: safeG.leadingAnchor, constant: 16).isActive = true
        origin.trailingAnchor.constraint(equalTo: safeG.trailingAnchor, constant: -16).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: origin.bottomAnchor, constant: 4).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: safeG.leadingAnchor, constant: 16).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: safeG.trailingAnchor, constant: -16).isActive = true
    }

}
