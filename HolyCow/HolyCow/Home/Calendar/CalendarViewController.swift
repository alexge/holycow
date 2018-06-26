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
    
    let currentDate = Date()
    let currentMonth: Date
    
    var selectedDate: Date
    var monthOnScreen: Date {
        get { return cyclingViewControllers[currentPageIndex].month }
    }
    
    let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = Calendar.current.timeZone
        return calendar
    }()
    
    let page1: MonthViewController
    let page2: MonthViewController
    let page3: MonthViewController
    
    var currentPageIndex = 0
    
    var cyclingViewControllers: [MonthViewController]
    
    var nextPageIndex: Int {
        get {
            if currentPageIndex == cyclingViewControllers.count - 1 {
                return 0
            }
            return currentPageIndex + 1
        }
    }
    
    var previousPageIndex: Int {
        get {
            if currentPageIndex == 0 {
                return cyclingViewControllers.count - 1
            }
            return currentPageIndex - 1
        }
    }
    
    var nextMonthToShow: Date {
        get { return calendar.nextMonth(from: monthOnScreen) }
    }
    
    var previousMonthToShow: Date {
        get { return calendar.previousMonth(from: monthOnScreen) }
    }
    
    init() {
        guard let firstOfMonth = calendar.date(from: DateComponents(calendar: calendar, timeZone: calendar.timeZone, year: calendar.component(.year, from: currentDate), month: calendar.component(.month, from: currentDate))) else {
            assert(false, "could not get first of month")
        }
        self.currentMonth = firstOfMonth
        self.selectedDate = currentDate
        page1 = MonthViewController(month: currentMonth, selectedDate: currentDate, calendar: calendar)
        page2 = MonthViewController(month: currentMonth, selectedDate: currentDate, calendar: calendar)
        page3 = MonthViewController(month: currentMonth, selectedDate: currentDate, calendar: calendar)
        cyclingViewControllers = [page1, page2, page3]
        super.init(nibName: nil, bundle: nil)
        updateMonthControllers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func updateMonthControllers() {
        cyclingViewControllers[nextPageIndex].bind(month: nextMonthToShow, selectedDate: selectedDate)
        cyclingViewControllers[previousPageIndex].bind(month: previousMonthToShow, selectedDate: selectedDate)
    }
}

extension CalendarViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let presentedVC = calendarContainer.viewControllers?[0] as? MonthViewController else {
            assert(false, "incorrect VC presented")
        }
        if finished && completed {
            if let index = cyclingViewControllers.index(of: presentedVC) {
                currentPageIndex = index
                updateMonthControllers()
            } else {
                assert(false, "cannot find presented vc in array")
            }
        }
    }
}

extension CalendarViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let monthVC = viewController as? MonthViewController, let _ = cyclingViewControllers.index(of: monthVC) else { return nil }
        
        return cyclingViewControllers[previousPageIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let monthVC = viewController as? MonthViewController, let _ = cyclingViewControllers.index(of: monthVC) else { return nil }
        
        return cyclingViewControllers[nextPageIndex]
    }
}

extension Calendar {
    func nextMonth(from month: Date) -> Date {
        if let nextMonth = date(byAdding: .month, value: 1, to: month) {
            return nextMonth
        } else {
            assert(false, "failed to get next month")
            return Date()
        }
    }
    
    func previousMonth(from month: Date) -> Date {
        if let previousMonth = date(byAdding: .month, value: -1, to: month) {
            return previousMonth
        } else {
            assert(false, "failed to get previous month")
            return Date()
        }
    }
}
