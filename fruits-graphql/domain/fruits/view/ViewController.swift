//
//  ViewController.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 05/09/22.
//

import UIKit
import RxSwift
import Swinject

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FruitTableViewCell.self, forCellReuseIdentifier: "fruit-cell")
        return tableView
    }()
    
    var viewModel: FruitsViewModel?
    private let disposeBag = DisposeBag()
    
    private var fruits = [FruitModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // Container untuk detail xib
    let container: Container = {
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
        viewModel?.getFruits()
    }
    
    @objc private func addTapped() {
        let vc = AddFruitViewController.instantiateFrom(storyboard: .fruit)
        UINavigationController.dismissViewController()
        UINavigationController.pushToRootViewController(vc, animated: true)
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = self.view.bounds
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func bindViewFruitsModel() {
        
        viewModel?
            .fruits
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { fruitList in
                self.fruits = fruitList
                self.tableView.reloadData()
                print("jumlah \(self.fruits.count)")
                print("reload data")
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
        
        viewModel?
            .success
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { message in
                print(message)
                self.tableView.reloadData()
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
        
        cell.label.text = data.name
        cell.actionBlock = {
            let id = data.id
            self.viewModel?.deleteFruit(id: id)
            self.viewModel?.getFruits()
        }
        
        cell.actionDetail = {
            let id = data.id
            let vc = self.container.resolve(DetailFruitXibViewController.self)
            vc?.id = id
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = FruitDetailViewController.instantiateFrom(storyboard: .detail)
        vc.id = fruits[indexPath.row].id
        UINavigationController.dismissViewController()
        UINavigationController.pushToRootViewController(vc, animated: true)
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
            
            self.viewModel?.deleteFruit(id: id)
            self.fruits.remove(at: indexPath.row)
            completionHandler(true)
        }
        action.image = UIImage(systemName: "trash.fill")

        return action
    }
}

