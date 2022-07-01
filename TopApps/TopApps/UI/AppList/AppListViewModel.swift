//
//  AppListViewModel.swift
//  TopApps
//
//  Created by APPSPIA on 2022/05/16.
//

import Foundation
import RxSwift
import RxCocoa

class AppListViewModel {
    let inAppListType: BehaviorSubject<AppListType> = BehaviorSubject(value: .free)
    let outItems : BehaviorSubject<[CellItem]> = BehaviorSubject(value: [])
    let outError = PublishSubject<(statusCode: Int?, error: Error?)>()
    let outLoading = PublishSubject<Bool>()
    let disposeBag = DisposeBag()
    
    func fetchData() {
        Observable.just(()).withLatestFrom(inAppListType).do { [weak self] _ in
            self?.outLoading.onNext(true)
        }.flatMap { type in
            API<TopAppsItem.TopApps>.topApps(type: type).request
        }.map {
            $0.feed.entry
        }.map {
            $0.map { AppListCellItem(item: $0) }
        }.do { [weak self] _ in
            self?.outLoading.onNext(false)
        }.subscribe(onNext: { [weak self] items in
            self?.outItems.onNext(items)
        }, onError: { [weak self] error in
            guard let error = error as? APIError else { return }
            switch error {
            case .httpError(_, let response, let error):
                self?.outError.onNext((response?.statusCode, error))
            }
        }).disposed(by: disposeBag)
    }
}
