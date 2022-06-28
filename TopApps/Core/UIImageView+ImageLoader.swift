//
//  UIImageView+ImageLoader.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/10.
//

import Foundation
import UIKit
import RxSwift

extension UIImageView {
    func loadImage(url: String?, disposeBag: DisposeBag) {
        guard let url = url, let url = URL(string: url) else { return }
        loadImage(url: url, disposeBag: disposeBag)
    }
    
    func loadImage(url: URL, disposeBag: DisposeBag) {
        ImageLoader.shared.loadImage(url: url).subscribe(onNext: { [weak self] image in
            self?.image = image
        }).disposed(by: disposeBag)
    }
}
