//
//  ReusableViewProtocol.swift
//  Media
//
//  Created by do hee kim on 2023/08/20.
//

import UIKit

protocol ReusableViewProtocol {
    
    static var identifier: String { get }
    
}

extension UIViewController: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UICollectionViewCell: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
