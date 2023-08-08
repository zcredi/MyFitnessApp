//
//  SelectWorkoutCollectionView.swift
//  MyFitnessApp
//
//  Created by Владислав on 07.06.2023.
//

import UIKit

class SelectWorkoutCollectionView: UICollectionView {
    
    //MARK: - Create UI
    
    private let collectionLayout = UICollectionViewFlowLayout()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionLayout)
        
        register(SelectWorkoutCell.self, forCellWithReuseIdentifier: SelectWorkoutCell.idSelectWorkoutCell)
        
        delegate = self
        dataSource = self
        
        configure()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .specialBrown
    }
    
    private func setupLayout() {
        collectionLayout.minimumInteritemSpacing = 3
        collectionLayout.scrollDirection = .horizontal
        layer.cornerRadius = 10
    }
}

//MARK: - UICollectionViewDataSource

extension SelectWorkoutCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectWorkoutCell.idSelectWorkoutCell, for: indexPath) as? SelectWorkoutCell else { return UICollectionViewCell() }
        
        return cell
    }
    
}

extension SelectWorkoutCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 3.7, height: collectionView.frame.height)
    }
}
