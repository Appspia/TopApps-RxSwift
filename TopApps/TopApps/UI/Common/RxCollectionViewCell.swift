//
//  RxCollectionViewCell.swift
//  TopApps
//
//  Created by APPSPIA on 2023/05/17.
//

import UIKit
import RxSwift
import RxCocoa

class RxCollectionViewCell: UICollectionViewCell {
    var outDisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        load()
        layout()
        bind()
    }
    
    func load() {} // Override me
    func layout() {} // Override me
    func bind() {} // Override me
    
    override func prepareForReuse() {
        super.prepareForReuse()
        outDisposeBag = DisposeBag()
    }
}
