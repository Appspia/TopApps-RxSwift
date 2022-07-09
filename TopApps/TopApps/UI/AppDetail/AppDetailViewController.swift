//
//  AppDetailViewController.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/11.
//

import UIKit
import RxSwift
import RxCocoa

class AppDetailViewController: UIViewController, AppStoreShowable {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var getButton: UIButton!
    
    let inItem = BehaviorSubject<TopAppsItem.Entry?>(value: nil)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        iconImageView.layer.cornerRadius = 25
        bind()
    }
    
    func bind() {
        // Item
        inItem.filter { $0 != nil }.map { $0! }.subscribe(onNext: { [weak self] item in
            self?.iconImageView.setImage(urlString: item.imImage?.last?.label ?? "")
            self?.titleLabel.text = item.title?.label
            self?.companyLabel.text = item.imArtist?.label
            self?.categoryLabel.text = item.category?.attributes?.label
            self?.textLabel.text = item.summary?.label
            self?.getButton.setTitle(item.imPrice?.label, for: .normal)
        }).disposed(by: disposeBag)
        
        // Get Button Event
        getButton.rx.tap.withLatestFrom(inItem).do(onNext: { _ in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }).subscribe(onNext: { [weak self] item in
            guard let self = self else { return }
            guard let appId = item?.id?.attributes?.imid else { return }
            self.showAppStore(appId: appId, sender: self)
        }).disposed(by: disposeBag)
    }
}

