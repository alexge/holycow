//
//  AppNavCoordinator.swift
//  HolyCow
//
//  Created by Alexander Ge on 6/3/18.
//  Copyright © 2018 G Dev. All rights reserved.
//

import Foundation
import UIKit

class AppNavCoordinator: NSObject {
    var rootViewController: UIViewController { return tabBarController }
    
    let tabBarController: UITabBarController
    
    override init() {
        tabBarController = UITabBarController()
        let profileVC = UIViewController()
        profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        profileVC.view.backgroundColor = .white
        let calendarVC = UIViewController()
        calendarVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        tabBarController.viewControllers = [profileVC,calendarVC]
    }
}
