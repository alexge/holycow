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
    
    var month: Date
    var selectedDate: Date
    let calendar: Calendar
    
    var monthView: UICollectionView = {
        let month = UICollectionView(frame: .zero, collectionViewLayout: CalendarLayout())
        month.translatesAutoresizingMaskIntoConstraints = false
        month.backgroundColor = .gray
        month.register(CalendarDayView.self)
        return month
    }()
    
    init(month: Date, selectedDate: Date, calendar: Calendar) {
        self.month = month
        self.selectedDate = selectedDate
        self.calendar = calendar
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
    
    func bind(month: Date, selectedDate: Date) {
        self.month = month
        self.selectedDate = selectedDate
        
        monthView.reloadData()
    }
    
}

extension MonthViewController: UICollectionViewDelegate {
    
}

extension MonthViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let range = calendar.range(of: .weekOfMonth, in: .month, for: month) else {
            assert(false, "failed to get weeks from the month")
            return 0
        }
        return range.upperBound - 1
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
        
        let isSelected = calendar.compare(cellDate, to: selectedDate, toGranularity: .day) == .orderedSame
        cell.bind(date: cellDate, currentMonth: month, calendar: calendar, isSelected: isSelected)
        
        return cell
    }
    
    private func date(for indexPath: IndexPath) -> Date? {
        guard indexPath.section < 7, indexPath.row < 7 else {
            assert(false, "invalid indexPath for cell layout")
            return nil
        }
        return calendar.date(from: DateComponents(calendar: calendar, year: calendar.component(.year, from: month), month: calendar.component(.month, from: month), weekday: indexPath.row + 1, weekOfMonth: indexPath.section + 1))
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
        contentView.backgroundColor = .white
        isHidden = false
    }
    
    func bind(date: Date, currentMonth: Date, calendar: Calendar, isSelected: Bool) {
        dateLabel.text = "\(calendar.component(.day, from: date))"
        if calendar.compare(date, to: currentMonth, toGranularity: .month) != .orderedSame {
            contentView.backgroundColor = .gray
        }
        if isSelected {
            contentView.backgroundColor = .yellow
        }
    }
}











