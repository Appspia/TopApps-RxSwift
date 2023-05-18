//
//  AppCellItem.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/10.
//

import UIKit
import RxSwift

class AppListCellItem: CellItem, AppStoreShowable {
    var cellMakingHandler: CellMakingHandler?
    var cellSelectedHandler: CellSelectedHandler?
    let outGetApp = PublishSubject<TopAppsItem.Entry>()
    
    init(item: TopAppsItem.Entry) {
        cellMakingHandler = { [weak self] sender, collectionView, indexPath in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppListCell", for: indexPath) as! AppListCell
            cell.inItem.onNext(item)
            cell.inRanking.onNext(indexPath.row + 1)
            cell.outGetApp.subscribe(onNext: {
                guard let appId = item.id?.attributes?.imid else { return }
                guard let sender = sender else { return }
                self?.showAppStore(appId: appId, sender: sender)
            }).disposed(by: cell.outDisposeBag)
            return cell
        }
        
        cellSelectedHandler = { sender in
            let viewController = AppDetailViewController()
            viewController.inItem.onNext(item)
            sender?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
