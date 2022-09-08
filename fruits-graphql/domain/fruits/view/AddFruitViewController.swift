//
//  AddFruitViewController.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 06/09/22.
//

import UIKit
import RxSwift
import RxCocoa

class AddFruitViewController: UIViewController {
    
    private let idTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "ID"
        return tf
    }()
    
    private let scientificNameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "scientificName"
        return tf
    }()
    
    private let treeNameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "treeName"
        return tf
    }()
    
    private let fruitNameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "fruitName"
        return tf
    }()
    
    private let familyTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "family"
        return tf
    }()
    
    private let originTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "origin"
        return tf
    }()
    
    private let descTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "desc"
        return tf
    }()
    
    private let bloomTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "bloom"
        return tf
    }()
    
    private let maturationTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "maturation"
        return tf
    }()
    
    private let lifeCycleTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "lifeCycle"
        return tf
    }()
    
    private let climaticTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "climatic"
        return tf
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemGray
        button.tintColor = .white
        button.layer.cornerRadius = 8
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
    var fruitViewModel = FruitsViewModel()
    
    private var isValid = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Fruit"

        configureUI()
        bindViewModel()
        setupRx()
    }
    
    private func bindViewModel() {
        viewModel
            .fruit
            .skip(1)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { fruit in
                print("success adding \(String(describing: fruit?.name))")
                self.fruitViewModel.getFruits()
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
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: stackView.frame.height)
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
//            scientificNameTextField,
//            treeNameTextField,
            fruitNameTextField,
//            familyTextField,
//            originTextField,
//            descTextField,
//            bloomTextField,
//            maturationTextField,
//            lifeCycleTextField,
//            climaticTextField,
        ].forEach { view in
            stackView.addArrangedSubview(view)
        }

        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 84).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupRx() {
        let idStream = idTextField.rx.text
            .orEmpty
            .skip(1)
            .map { !$0.isEmpty }
        
        idStream.subscribe(
            onNext: { value in
                self.idTextField.rightViewMode = value ? .never : .always
            }
        ).disposed(by: disposeBag)
        
        let nameStream = fruitNameTextField.rx.text
            .orEmpty
            .skip(1)
            .map { !$0.isEmpty }
        
        nameStream.subscribe(
            onNext: { value in
                self.fruitNameTextField.rightViewMode = value ? .never : .always
            }
        ).disposed(by: disposeBag)
        
        let invalidFieldsStream = Observable.combineLatest(
            idStream,
            nameStream
        ) { id, name in
            id && name
        }
        
        invalidFieldsStream.subscribe(
            onNext: { isValid in
                if (isValid) {
                    self.isValid = true
                    self.saveButton.isEnabled = true
                    self.saveButton.backgroundColor = UIColor.systemGreen
                } else {
                    self.isValid = false
                    self.saveButton.isEnabled = false
                    self.saveButton.backgroundColor = UIColor.systemGray
                }
            }
        ).disposed(by: disposeBag)
    }
    
    @objc private func savePressed() {
        if let id = idTextField.text, let fruitName = fruitNameTextField.text, isValid  {
            viewModel.addFruit(
                addFruitId: id,
                scientificName: "scientName",
                treeName: "treeName",
                fruitName: fruitName,
                family: "family",
                origin: "origin",
                description: "desc",
                bloom: "bloom",
                maturationFruit: "maturation",
                lifeCycle: "lifeCycle",
                climaticZone: "climatic")
        }
    }

}
