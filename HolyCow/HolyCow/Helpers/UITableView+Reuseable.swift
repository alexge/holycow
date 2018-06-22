//
//  UITableView+Reuseable.swift
//  HolyCow
//
//  Created by Alexander Ge on 6/22/18.
//  Copyright © 2018 G Dev. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: ReusableView, T: NibLoadableView {
        if let cell: T = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T {
            return cell
        } else {
            register(T.self)
        }
        return dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: ReusableView {
        if let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T {
            return cell
        } else {
            register(T.self)
        }
        return dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as! T
    }
    
    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? where T: ReusableView {
        if let cell = self.dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T {
            return cell
        } else {
            register(T.self, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
            return dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as! T?
        }
    }
}
