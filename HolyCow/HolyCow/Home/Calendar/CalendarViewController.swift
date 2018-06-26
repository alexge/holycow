//
//  CalendarViewController.swift
//  HolyCow
//
//  Created by Alexander Ge on 6/22/18.
//  Copyright © 2018 G Dev. All rights reserved.
//

import Foundation
import UIKit

class CalendarViewController: UIViewController {
    
    let calendarContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    let page1: UIViewController = {
        let vc = MonthViewController(month: Date(), selectedDate: Date())
        return vc
    }()
    
    let page2: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }()
    
    let page3: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .yellow
        return vc
    }()
    
    var cyclingViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cyclingViewControllers = [page1, page2, page3]
        setupCalendarContainer()
    }
    
    func setupCalendarContainer() {
        addChildViewController(calendarContainer)
        calendarContainer.didMove(toParentViewController: self)
        view.addSubview(calendarContainer.view)
        calendarContainer.view.fillSafeAreasInSuperview(insets: UIEdgeInsetsMake(50, 0, 50, 0))
        calendarContainer.setViewControllers([cyclingViewControllers[0]], direction: .forward, animated: true, completion: nil)
        calendarContainer.delegate = self
        calendarContainer.dataSource = self
    }
}

extension CalendarViewController: UIPageViewControllerDelegate {
    
}

extension CalendarViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = cyclingViewControllers.index(of: viewController) else { return nil }
        
        if index == 0 {
            return cyclingViewControllers[cyclingViewControllers.count - 1]
        }
        
        return cyclingViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = cyclingViewControllers.index(of: viewController) else { return nil }
        
        if index == cyclingViewControllers.count - 1 {
            return cyclingViewControllers[0]
        }
        
        return cyclingViewControllers[index + 1]
    }
}
