//
//  AppListCell.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/10.
//

import UIKit
import RxSwift
import RxCocoa

class AppListCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var getButton: UIButton!
    
    let inItem: BehaviorSubject<TopAppsItem.Entry?> = BehaviorSubject(value: nil)
    let inRanking = PublishSubject<Int>()
    let outGetApp = PublishSubject<Void>()
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = 15
        bind()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        bind()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        layoutAttributes.frame.size.height = contentView.systemLayoutSizeFitting(layoutAttributes.size).height
        return layoutAttributes
    }
    
    func bind() {
        // Item
        inItem.filter { $0 != nil }.map { $0! }.subscribe(onNext: { [weak self] item in
            guard let self = self else { return }
            self.iconImageView.setImage(urlString: item.imImage?.last?.label ?? "")
            self.titleLabel.text = item.title?.label
            self.infoLabel.text = item.category?.attributes?.label
            self.getButton.setTitle(item.imPrice?.label, for: .normal)
        }).disposed(by: disposeBag)
        
        // Ranking
        inRanking.map { "\($0)" }.bind(to: rankingLabel.rx.text).disposed(by: disposeBag)
        
        // Get Button Event
        getButton.rx.tap.do(onNext: { _ in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }).bind(to: outGetApp).disposed(by: disposeBag)
    }
}
