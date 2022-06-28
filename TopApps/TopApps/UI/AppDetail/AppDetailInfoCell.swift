//
//  AppDetailInfoCell.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/14.
//

import UIKit
import RxSwift
import RxCocoa

class AppDetailInfoCell: UICollectionViewCell {
    @IBOutlet weak var cellWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = 30
        cellWidthConstraint.constant = UIScreen.main.bounds.width
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func setup(item: Response.Entry) {
        iconImageView.image = nil
        iconImageView.loadImage(url: item.imImage?.last?.label, disposeBag: disposeBag)
        titleLabel.text = item.title?.label
        artistLabel.text = item.imArtist?.label
        summaryLabel.text = item.summary?.label
    }
    

}
