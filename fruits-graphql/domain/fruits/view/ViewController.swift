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
    
    private var fruits = [FruitModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fruits"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(addTapped))
    
        configureTableView()
        bindViewFruitsModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFruits()
    }
    
    @objc private func addTapped() {
        let vc = AddFruitViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = self.view.bounds
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func bindViewFruitsModel() {
        viewModel
            .fruits
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { fruitList in
                self.fruits = fruitList
                self.tableView.reloadData()
                print("jumlah \(self.fruits.count)")
                print("reload data")
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
        
        viewModel
            .success
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { message in
                print(message)
                self.getFruits()
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)

    }
    
    private func getFruits() {
        viewModel
            .fruits
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { fruitList in
                self.fruits = fruitList
                self.tableView.reloadData()
                print("jumlah \(self.fruits.count)")
                print("reload data")
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
            print("delete button presed on \(indexPath.row+1)")
            
            let id = self.fruits[indexPath.row].id
            self.viewModel.deleteFruit(id: id)
            self.fruits.remove(at: indexPath.row)
        }
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = deleteContextualAction(forRowat: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }

    private func deleteContextualAction(forRowat indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") {
            action, view, completionHandler in
            let id = self.fruits[indexPath.row].id
            
            self.viewModel.deleteFruit(id: id)
            self.fruits.remove(at: indexPath.row)
            print("swiped")
            completionHandler(true)
        }
        action.image = UIImage(systemName: "trash.fill")

        return action
    }
}

