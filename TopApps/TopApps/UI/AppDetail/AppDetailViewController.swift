//
//  AppDetailViewController.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/11.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class AppDetailViewController: UIViewController, AppStoreShowable {
    lazy var contentView = AppDetailView()
    
    let inItem = BehaviorSubject<TopAppsItem.Entry?>(value: nil)
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        bind()
    }
    
    func bind() {
        // Item
        let item = inItem.compactMap { $0 }
        
        // App Icon Image
        item.map { URL(string: $0.imImage?.last?.label ?? "") }.subscribe(onNext: { [weak self] url in
            self?.contentView.iconImageView.kf.setImage(with: url)
        }).disposed(by: disposeBag)
        
        // Title Label
        item.map { $0.title?.label }.bind(to: contentView.titleLabel.rx.text).disposed(by: disposeBag)
        
        // Company Label
        item.map { $0.imArtist?.label }.bind(to: contentView.companyLabel.rx.text).disposed(by: disposeBag)
        
        // Category Label
        item.map { $0.category?.attributes?.label }.bind(to: contentView.categoryLabel.rx.text).disposed(by: disposeBag)
        
        // Description Label
        item.map { $0.summary?.label }.bind(to: contentView.descriptionLabel.rx.text).disposed(by: disposeBag)
        
        // Get Button
        item.map { $0.imPrice?.label }.bind(to: contentView.getButton.rx.title()).disposed(by: disposeBag)

        // Get Button Event
        contentView.getButton.rx.tap.withLatestFrom(inItem).do(onNext: { _ in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }).subscribe(onNext: { [weak self] item in
            guard let self = self else { return }
            guard let appId = item?.id?.attributes?.imid else { return }
            self.showAppStore(appId: appId, sender: self)
        }).disposed(by: disposeBag)
    }
}

