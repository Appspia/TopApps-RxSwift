//
//  CellItem.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/10.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

typealias CellSelectedHandler = (_ sender: UIViewController?) -> Void
typealias CellMakingHandler = (_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell

protocol CellItem {
    var cellMakingHandler: CellMakingHandler { get set }
    var cellSelectedHandler: CellSelectedHandler? { get set }
}
