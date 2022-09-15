//
//  Storyboard.swift
//  fruits-graphql
//
//  Created by agustiyan on 15/09/22.
//

import Foundation
import UIKit

extension UIViewController {
    static func instantiateFrom(storyboard: Storyboard) -> Self {
        return storyboard.viewController(ofClass: self)
    }
    
    static var storyboardId: String {
        return "\(self)"
    }
}

enum Storyboard: String {
    
    case fruit
    case detail
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue.capitalized.replacingOccurrences(of: " ", with: ""), bundle: nil)
    }
    
    func viewController<T: UIViewController>(ofClass viewController: T.Type) -> T {
        let storyboardVc = (viewController as UIViewController.Type).storyboardId
        return instance.instantiateViewController(withIdentifier: storyboardVc) as! T
    }
}
