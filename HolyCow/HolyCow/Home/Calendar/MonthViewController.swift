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
        return cell
    }
}

class CalendarLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
        itemSize = CGSize(width: 30, height: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CalendarDayView: UICollectionViewCell, ReusableView {
    static var defaultReuseIdentifier: String  = "CalendarDayView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
