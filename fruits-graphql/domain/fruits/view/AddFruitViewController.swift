//
//  AddFruitViewController.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 06/09/22.
//

import UIKit
import RxSwift

class AddFruitViewController: UIViewController {
    
    private let idTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40.0, height: 40.0)
        tf.borderStyle = .line
        tf.placeholder = "ID"
        return tf
    }()
    
    private let scientificNameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40.0, height: 40.0)
        tf.borderStyle = .line
        tf.placeholder = "scientificName"
        return tf
    }()
    
    private let treeNameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40.0, height: 40.0)
        tf.borderStyle = .line
        tf.placeholder = "treeName"
        return tf
    }()
    
    private let fruitNameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40.0, height: 40.0)
        tf.borderStyle = .line
        tf.placeholder = "fruitName"
        return tf
    }()
    
    private let familyTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40.0, height: 40.0)
        tf.borderStyle = .line
        tf.placeholder = "family"
        return tf
    }()
    
    private let originTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40.0, height: 40.0)
        tf.borderStyle = .line
        tf.placeholder = "origin"
        return tf
    }()
    
    private let descTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40.0, height: 40.0)
        tf.borderStyle = .line
        tf.placeholder = "desc"
        return tf
    }()
    
    private let bloomTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40.0, height: 40.0)
        tf.borderStyle = .line
        tf.placeholder = "bloom"
        return tf
    }()
    
    private let maturationTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40.0, height: 40.0)
        tf.borderStyle = .line
        tf.placeholder = "maturation"
        return tf
    }()
    
    private let lifeCycleTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40.0, height: 40.0)
        tf.borderStyle = .line
        tf.placeholder = "lifeCycle"
        return tf
    }()
    
    private let climaticTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40.0, height: 40.0)
        tf.borderStyle = .line
        tf.placeholder = "climatic"
        return tf
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40.0, height: 40.0)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        return button
    }()
    
    private let stackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .vertical
        stView.distribution = .fillEqually
        stView.spacing = 4.0
        return stView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let viewModel = AddFruitViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    
    override func viewDidLayoutSubviews()
      {
          scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 1000) // set height according you
      }
    
    private func configureUI() {
        view.addSubview(scrollView)
        
        let safeG = view.safeAreaLayoutGuide
        
        scrollView.leadingAnchor.constraint(equalTo: safeG.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeG.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeG.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeG.bottomAnchor).isActive = true
        
        scrollView.addSubview(stackView)
        scrollView.addSubview(saveButton)
        
        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)

        [
            idTextField,
            scientificNameTextField,
            treeNameTextField,
            fruitNameTextField,
            familyTextField,
            originTextField,
            descTextField,
            bloomTextField,
            maturationTextField,
            lifeCycleTextField,
            climaticTextField,
        ].forEach { view in
            stackView.addArrangedSubview(view)
        }

        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
    }
    
    @objc private func savePressed() {
        if let id = idTextField.text,
           let scientName = scientificNameTextField.text,
           let treeName = treeNameTextField.text,
           let fruitName = fruitNameTextField.text,
           let family = familyTextField.text,
           let origin = originTextField.text,
           let desc = descTextField.text,
           let bloom = bloomTextField.text,
           let maturation = maturationTextField.text,
           let lifeCycle = lifeCycleTextField.text,
           let climatic = climaticTextField.text {
            viewModel.addFruit(
                addFruitId: id,
                scientificName: scientName,
                treeName: treeName,
                fruitName: fruitName,
                family: family,
                origin: origin,
                description: desc,
                bloom: bloom,
                maturationFruit: maturation,
                lifeCycle: lifeCycle,
                climaticZone: climatic)
        }
        
        viewModel
            .fruit
            .skip(1)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { fruit in
                print("success adding \(String(describing: fruit?.name))")
                self.navigationController?.popViewController(animated: true)
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
