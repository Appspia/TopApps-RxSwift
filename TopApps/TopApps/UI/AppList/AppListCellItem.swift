//
//  AppCellItem.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/10.
//

import UIKit
import RxSwift
import RxRelay

class AppListCellItem: CellItem {
    var cellMakingHandler: CellMakingHandler
    var cellSelectedHandler: CellSelectedHandler?
    var disposeBag = DisposeBag()
    
    init(item: Response.Entry) {
        cellMakingHandler = { collectionView, indexPath in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppListCell", for: indexPath) as! AppListCell
            cell.setup(item: item, ranking: indexPath.row + 1)
            return cell
        }
        
        cellSelectedHandler = { sender in
            guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppDetailViewController") as? AppDetailViewController else { return }
            viewController.setup(item: item)
            sender?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
