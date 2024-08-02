//
//  CollectionTableViewCell.swift
//  WhereToGo
//
//  Created by 권정근 on 8/2/24.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    static let identifier = "CollectionTableViewCell"
    
    // MARK: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 250, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .systemMint
        contentView.addSubview(collectionView)
        
        //collectionViewDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
//    private func collectionViewDelegate() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
}

// MARK: - Extensions
//extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
//}
