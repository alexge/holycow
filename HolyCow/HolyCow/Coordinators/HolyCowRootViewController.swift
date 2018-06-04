//
//  HolyCowRootViewController.swift
//  HolyCow
//
//  Created by Alexander Ge on 6/3/18.
//  Copyright © 2018 G Dev. All rights reserved.
//

import Foundation
import UIKit

class HolyCowRootViewController: UIViewController {
    private var currentChild: UIViewController?
    private var currentCoordinator: NSObject?
    
    override func viewDidLoad() {
        let app = AppNavCoordinator()
        currentCoordinator = app
        
        show(child: app.rootViewController)
    }
    
    private func show(child: UIViewController) {
        if let current = currentChild {
            current.view.removeFromSuperview()
            current.removeFromParentViewController()
        }
        
        addChildViewController(child)
        view.addSubview(child.view)
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        child.view.frame = view.bounds
        
        child.didMove(toParentViewController: self)
        currentChild = child
        
        view.backgroundColor = child.view.backgroundColor
    }
}
