//
//  FruitTableViewCell.swift
//  fruits-graphql
//
//  Created by Agus Tiyansyah Syam on 06/09/22.
//

import UIKit

class FruitTableViewCell: UITableViewCell {
    
    var actionBlock: (() -> Void)? = nil
    var actionDetail: (() -> Void)? = nil
    
    let button: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        btn.tintColor = .systemPink
        return btn
    }()
    
    let label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        return lbl
    }()
    
    let xibButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Detail XIB", for: .normal)
        btn.setTitleColor(UIColor.systemPink, for: .normal)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(button)
        button.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        contentView.addSubview(xibButton)
        xibButton.addTarget(self, action: #selector(detailXibPressed), for: .touchUpInside)
        xibButton.translatesAutoresizingMaskIntoConstraints = false
        xibButton.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -8).isActive = true
        xibButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        xibButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        xibButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: xibButton.leadingAnchor, constant: -10).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func deleteButtonPressed() {
        actionBlock?()
    }
    
    @objc func detailXibPressed() {
        actionDetail?()
    }
    
}
