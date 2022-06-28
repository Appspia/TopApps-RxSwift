//
//  AppDetailInfoCellItem.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/14.
//

import UIKit
import RxSwift
import RxRelay

class AppDetailInfoCellItem: CellItem {
    var cellMakingHandler: CellMakingHandler
    var cellSelectedHandler: CellSelectedHandler?
    var disposeBag = DisposeBag()
    
    init(item: Response.Entry) {
        cellMakingHandler = { collectionView, indexPath in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppDetailInfoCell", for: indexPath) as! AppDetailInfoCell
            cell.setup(item: item)
            return cell
        }
        
        cellSelectedHandler = { sender in

        }
    }
}
