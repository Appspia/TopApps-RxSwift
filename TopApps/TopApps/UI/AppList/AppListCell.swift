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
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = 15
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70)
        return layoutAttributes
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func setup(item: Response.Entry, ranking: Int) {
        iconImageView.image = nil
        iconImageView.loadImage(url: item.imImage?.last?.label, disposeBag: disposeBag)
        rankingLabel.text = "\(ranking)"
        titleLabel.text = item.title?.label
        infoLabel.text = item.category?.attributes?.label
        getButton.setTitle(item.imPrice?.label, for: .normal)
    }
}
