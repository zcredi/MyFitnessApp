//
//  CalendarView.swift
//  MyFitnessApp
//
//  Created by Владислав on 20.02.2023.
//

import UIKit

class CalendarView: UIView {
    enum Constants {
        static let idCalendarCell: String = "idCalendarCell"
        static let collectionViewSizeSpacing: CGFloat = 5.0
        static let collectionViewLeadingSpacing: CGFloat = 105.0
        static let collectionViewTrailingSpacing: CGFloat = 10.0
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: Constants.idCalendarCell)
        setupViews()
        setConstraints()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupViews() {
        backgroundColor = .specialGreen
        layer.cornerRadius = 10
        addSubview(collectionView)
    }
    
}

//MARK: - setConstraints()

extension CalendarView {
    private func setConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.collectionViewSizeSpacing),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.collectionViewSizeSpacing),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.collectionViewTrailingSpacing),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.collectionViewLeadingSpacing)
        ])
    }
}

//MARK: - UICollectionViewDataSource

extension CalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.idCalendarCell, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 8,
               height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
}

extension CalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
