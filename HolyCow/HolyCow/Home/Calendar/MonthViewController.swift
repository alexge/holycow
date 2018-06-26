//
//  MonthViewController.swift
//  HolyCow
//
//  Created by Alexander Ge on 6/22/18.
//  Copyright © 2018 G Dev. All rights reserved.
//

import Foundation
import UIKit

class MonthViewController: UIViewController {
    
    let month: Date
    var selectedDate: Date?
    
    let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = Calendar.current.timeZone
        return calendar
    }()
    
    var monthView: UICollectionView = {
        let month = UICollectionView(frame: .zero, collectionViewLayout: CalendarLayout())
        month.translatesAutoresizingMaskIntoConstraints = false
        month.backgroundColor = .gray
        month.register(CalendarDayView.self)
        return month
    }()
    
    init(month: Date, selectedDate: Date?) {
        self.month = month
        self.selectedDate = selectedDate
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(monthView)
        setupMonthView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMonthView() {
        monthView.fillSafeAreasInSuperview()
        monthView.delegate = self
        monthView.dataSource = self
    }
    
    func firstDayOfMonth(for date: Date) -> Date {
        guard let dateInterval = calendar.dateInterval(of: .month, for: date) else {
            assert(false, "No month for date")
            return Date()
        }
        return dateInterval.start
    }
    
    /// Returns the week of the month that the date falls in.
    /// Return value is 1-indexed, not 0-indexed
    ///
    /// - Parameter date: Date to evaluate
    /// - Returns: Week of month that the given date falls in. 0-indexed
    func weekOfMonth(for date: Date) -> Int {
        return calendar.component(.weekOfMonth, from: date) - 1
    }
    
    /// Returns an integer value for the day of the week of the given date
    ///
    /// - Parameter date: Date to evaluate
    /// - Returns: Integer value for the day of the week of the given date. Returns 1 for sunday, 7 for saturday
    func dayOfWeek(for date: Date) -> Int {
        return calendar.component(.weekday, from: date)
    }
    
    
    private func date(for indexPath: IndexPath) -> Date? {
        guard indexPath.section < 7, indexPath.row < 7 else {
            assert(false, "invalid indexPath for cell layout")
            return nil
        }
        return calendar.date(from: DateComponents(calendar: calendar, year: calendar.component(.year, from: month), month: calendar.component(.month, from: month), weekday: indexPath.row + 1, weekOfMonth: indexPath.section + 1))
    }
}

extension MonthViewController: UICollectionViewDelegate {
    
}

extension MonthViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellDate = date(for: indexPath) else {
            assert(false, "failed date for cell")
            return UICollectionViewCell()
        }
        let cell: CalendarDayView = monthView.dequeueReusableCell(for: indexPath)
        let dateInt = calendar.component(.day, from: cellDate)
        cell.bind(date: dateInt)
        return cell
    }
}

class CalendarLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
        sectionInset = UIEdgeInsetsMake(10, 10, 0, 0)
        itemSize = CGSize(width: 30, height: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CalendarDayView: UICollectionViewCell, ReusableView {
    static var defaultReuseIdentifier: String  = "CalendarDayView"
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.contentView.backgroundColor = .white
        contentView.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
    }
    
    func bind(date: Int) {
        dateLabel.text = "\(date)"
    }
}











