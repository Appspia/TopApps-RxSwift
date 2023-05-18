//
//  LayoutView.swift
//  TopApps
//
//  Created by APPSPIA on 2023/05/17.
//

import UIKit

class LayoutView: UIView {
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
}
