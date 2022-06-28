//
//  AppDetailViewController.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/11.
//

import UIKit
import RxSwift
import RxCocoa

class AppDetailViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var item: Response.Entry?
    let viewModel = AppDetailViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setup(item: Response.Entry) {
        view.layoutIfNeeded()
        navigationItem.largeTitleDisplayMode = .never
//        title = item.title?.label
        bind()
        viewModel.fetchData(item: item)
    }
    
    func bind() {
        // Register Cells
        collectionView.register(UINib(nibName: "AppDetailInfoCell", bundle: nil), forCellWithReuseIdentifier: "AppDetailInfoCell")
        
        // Cell Selected
        collectionView.rx.modelSelected(CellItem.self).subscribe(onNext: { [weak self] item in
            item.cellSelectedHandler?(self)
        }).disposed(by: disposeBag)
        
        // ViewModel Output : Items
        viewModel.output.items.bind(to: collectionView.rx.items) { collectionView, row, item in
            item.cellMakingHandler(collectionView, IndexPath(row: row, section: 0))
        }.disposed(by: disposeBag)
    }
    
}

