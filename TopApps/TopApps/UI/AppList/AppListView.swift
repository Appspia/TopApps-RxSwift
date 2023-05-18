//
//  AppListView.swift
//  TopApps
//
//  Created by APPSPIA on 2023/05/17.
//

import UIKit
import SnapKit
import Then

class AppListView: LayoutView {
    /// Collection
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(70))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
        section.interGroupSpacing = 16
        
        $0.collectionViewLayout = UICollectionViewCompositionalLayout(section: section)
        $0.register(AppListCell.self, forCellWithReuseIdentifier: "AppListCell")
    }

    /// Loadin
    let indicatorView = UIActivityIndicatorView(style: .large).then {
        $0.color = .lightGray
        $0.startAnimating()
        $0.isHidden = true
    }
    
    override func load() {
        [collectionView, indicatorView].forEach { addSubview($0) }
    }
    
    override func layout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
