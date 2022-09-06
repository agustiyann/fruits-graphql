//
//  FruitDetailViewController.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 06/09/22.
//

import UIKit

class FruitDetailViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

}
