//
//  AppListCell.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/10.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class AppListCell: RxCollectionViewCell {
    /// Main Stack
    private let mainStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 8
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    /// Center Stack
    private let centerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
    }
    
    /// App Icon
    let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    /// Ranking
    let rankingLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        $0.textAlignment = .center
    }
    
    /// App Title
    let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.numberOfLines = 2
    }
    
    /// App Info
    let infoLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = UIColor.gray
    }
    
    /// Get Button
    let getButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor.systemFill
        $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    let inItem = BehaviorSubject<TopAppsItem.Entry?>(value: nil)
    let inRanking = PublishSubject<Int>()
    let outGetApp = PublishSubject<Void>()
    private var disposeBag = DisposeBag()
    
    override func load() {
        addSubview(mainStackView)
        
        // Main Stack
        mainStackView.addArrangedSubview(iconImageView)
        mainStackView.addArrangedSubview(rankingLabel)
        mainStackView.addArrangedSubview(centerStackView)
        mainStackView.addArrangedSubview(getButton)
        
        // Center Stack
        centerStackView.addArrangedSubview(titleLabel)
        centerStackView.addArrangedSubview(infoLabel)
    }
    
    override func layout() {
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(60)
        }
        
        rankingLabel.setContentHuggingPriority(.required, for: .horizontal)
        getButton.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    override func bind() {
        // Item
        let item = inItem.compactMap { $0 }
        
        // App Icon Image
        item.map { URL(string: $0.imImage?.last?.label ?? "") }.subscribe(onNext: { [weak self] url in
            self?.iconImageView.kf.setImage(with: url)
        }).disposed(by: disposeBag)
        
        // Ranking Label
        inRanking.map { "\($0)" }.bind(to: rankingLabel.rx.text).disposed(by: disposeBag)
        
        // Title Label
        item.map { $0.title?.label }.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        
        // Info Label
        item.map { $0.category?.attributes?.label }.bind(to: infoLabel.rx.text).disposed(by: disposeBag)
        
        // Get Button
        item.map { $0.imPrice?.label }.bind(to: getButton.rx.title()).disposed(by: disposeBag)
        
        // Get Button Event
        getButton.rx.tap.do(onNext: { _ in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }).bind(to: outGetApp).disposed(by: disposeBag)
    }
}
