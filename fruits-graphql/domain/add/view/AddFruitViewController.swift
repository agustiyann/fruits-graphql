//
//  AddFruitViewController.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 06/09/22.
//

import UIKit

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
    
    private let stackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .vertical
        stView.distribution = .fillEqually
        stView.spacing = 4.0
        return stView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(stackView)

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
            climaticTextField
        ].forEach { view in
            stackView.addArrangedSubview(view)
        }

        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 456).isActive = true
    }

}
