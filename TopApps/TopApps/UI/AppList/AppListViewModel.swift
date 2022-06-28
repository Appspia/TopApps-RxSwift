//
//  AppListViewModel.swift
//  TopApps
//
//  Created by APPSPIA on 2022/05/16.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class AppListViewModel: ViewModel {
    struct Input {}
    struct Output {
        let items : BehaviorRelay<[CellItem]> = BehaviorRelay(value: [])
        let error = PublishRelay<(statusCode: Int?, error: Error?)>()
        let loading = PublishRelay<Bool>()
    }
    
    let input = Input()
    let output = Output()
    var disposeBag = DisposeBag()

    func fetchData() {
        Observable.just(()).do { [weak self] _ in
            self?.output.loading.accept(true)
        }.flatMap { _ in
            api.topApps()
        }.map {
            $0.feed.entry
        }.map {
            $0.map { AppListCellItem(item: $0) }
        }.do { [weak self] _ in
            self?.output.loading.accept(false)
        }.asSingle().subscribe(onSuccess: { [weak self] items in
            self?.output.items.accept(items)
        }, onFailure: { [weak self] error in
            guard let error = error as? APIError else { return }
            switch error {
            case .httpError(_, let response, let error):
                self?.output.error.accept((response?.statusCode, error))
            }
        }).disposed(by: disposeBag)
    }
}
