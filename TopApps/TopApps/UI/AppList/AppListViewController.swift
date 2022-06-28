//
//  AppListViewController.swift
//  TopApps
//
//  Created by APPSPIA on 2022/05/16.
//

import UIKit
import RxSwift
import RxCocoa

class AppListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    let viewModel = AppListViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Apps"
        bind()
        // ViewModel Fetch Data
        viewModel.fetchData()
    }
    
    func bind() {
        // Register Cells
        collectionView.register(UINib(nibName: "AppListCell", bundle: nil), forCellWithReuseIdentifier: "AppListCell")
        
        // Cell Selected
        collectionView.rx.modelSelected(CellItem.self).subscribe(onNext: { [weak self] item in
            item.cellSelectedHandler?(self)
        }).disposed(by: disposeBag)
        
        // ViewModel Output : Items
        viewModel.output.items.bind(to: collectionView.rx.items) { collectionView, row, item in
            item.cellMakingHandler(collectionView, IndexPath(row: row, section: 0))
        }.disposed(by: disposeBag)
        
        // ViewModel Output : Error
        viewModel.output.error.subscribe(onNext: { [weak self] (statusCode: Int?, error: Error?) in
            self?.showAlert(message: error?.localizedDescription, retryHandler: {
                self?.viewModel.fetchData()
            })
        }).disposed(by: disposeBag)
        
        // ViewModel Output : Loading
        viewModel.output.loading.map { !$0 }.bind(to: indicatorView.rx.isHidden).disposed(by: disposeBag)
    }
    
    func showAlert(message: String?, retryHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            retryHandler?()
        }))
        present(alertController, animated: true)
    }
}
