//
//  ViewController.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: "FruitTableViewCell", bundle: nil), forCellReuseIdentifier: "fruit-cell")
        return tableView
    }()
    
    private let viewModel = FruitsViewModel()
    private let disposeBag = DisposeBag()
    
    private var fruits = [FruitModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fruits"
    
        configureTableView()
        bindViewModel()
        viewModel.getFruits()
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = self.view.bounds
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel
            .fruits
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { fruitList in
                self.fruits = fruitList
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel
            .loading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { loading in
                loading ? print("loading") : print("finish")
            })
            .disposed(by: disposeBag)
        
        viewModel
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

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fruit-cell", for: indexPath) as! FruitTableViewCell
        let data = fruits[indexPath.row]
        
        cell.titleLabel.text = "\(data.name)"
        cell.actionBlock = {
            print("button pressed \(indexPath.row+1)")
        }
        
        return cell
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        print("handle tap")
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

