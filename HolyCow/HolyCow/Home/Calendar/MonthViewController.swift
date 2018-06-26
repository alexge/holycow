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
        let cell: CalendarDayView = monthView.dequeueReusableCell(for: indexPath)
        cell.bind(date: 1)
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
    }
    
    func bind(date: Int) {
        dateLabel.text = "\(date)"
    }
}











