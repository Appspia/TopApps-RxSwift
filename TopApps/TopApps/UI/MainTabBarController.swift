//
//  MainTabBarController.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/28.
//

import UIKit
import RxSwift

class MainTabBarController: UITabBarController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [tapViewController(type: .free), tapViewController(type: .paid), tapViewController(type: .grossing)]
        bind()
    }
    
    func bind() {
        rx.didSelect.subscribe(onNext: { _ in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }).disposed(by: disposeBag)
    }
    
    func tapViewController(type: AppListType) -> UIViewController {
        let title: String
        let iconName: String
        switch type {
        case .free:
            title = "FREE"
            iconName = "no-cash"
        case .paid:
            title = "PAID"
            iconName = "rank"
        case .grossing:
            title = "GROSSING"
            iconName = "trophy"
        }
        let appListViewController = storyboard?.instantiateViewController(identifier: "AppListViewController") as! AppListViewController
        appListViewController.inAppListType.onNext(type)
        let navigationController = UINavigationController(rootViewController: appListViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem = UITabBarItem(title: title, image: UIImage(named: iconName), selectedImage: UIImage(named: iconName))
        return navigationController
    }
}
