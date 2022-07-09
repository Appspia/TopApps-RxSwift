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
    let inAppListType = BehaviorSubject<AppListType>(value: .free)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Bind RX
        bind()
        
        // ViewModel Fetch Data
        viewModel.fetchData()
    }
    
    func bind() {
        // Title
        inAppListType.subscribe(onNext: { [weak self] type in
            switch type {
            case .free:
                self?.title = "TOP FREE APPS"
            case .paid:
                self?.title = "TOP PAID APPS"
            case .grossing:
                self?.title = "TOP GROSSING APPS"
            }
        }).disposed(by: disposeBag)
        
        // Collection View Delegate
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        // Register Cells
        collectionView.register(UINib(nibName: "AppListCell", bundle: nil), forCellWithReuseIdentifier: "AppListCell")
        
        // Cell Selected
        collectionView.rx.modelSelected(CellItem.self).subscribe(onNext: { [weak self] item in
            item.cellSelectedHandler?(self)
        }).disposed(by: disposeBag)
        
        // Bind AppListType to ViewModel
        inAppListType.bind(to: viewModel.inAppListType).disposed(by: disposeBag)
        
        // ViewModel Output : Items
        viewModel.outItems.bind(to: collectionView.rx.items) { [weak self] collectionView, row, item in
            item.cellMakingHandler?(self, collectionView, IndexPath(row: row, section: 0)) ?? UICollectionViewCell()
        }.disposed(by: disposeBag)
        
        // ViewModel Output : Error
        viewModel.outError.subscribe(onNext: { [weak self] (statusCode: Int?, error: Error?) in
            guard let self = self else { return }
            self.showAlert(message: error?.localizedDescription, retryHandler: {
                self.viewModel.fetchData()
            })
        }).disposed(by: disposeBag)
        
        // ViewModel Output : Loading
        viewModel.outLoading.map { !$0 }.bind(to: indicatorView.rx.isHidden).disposed(by: disposeBag)
    }
    
    func showAlert(message: String?, retryHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            retryHandler?()
        }))
        present(alertController, animated: true)
    }
}

extension AppListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 70)
    }
}
