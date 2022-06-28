//
//  AppDetailViewModel.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/14.
//

import RxSwift
import RxCocoa
import Alamofire

class AppDetailViewModel: ViewModel {
    struct Input {}
    struct Output {
        let items : BehaviorRelay<[CellItem]> = BehaviorRelay(value: [])
        let error = PublishRelay<(statusCode: Int?, error: Error?)>()
        let loading = PublishRelay<Bool>()
    }
    
    let input = Input()
    let output = Output()
    var disposeBag = DisposeBag()

    func fetchData(item: Response.Entry) {
        Observable.just(item).map {
            AppDetailInfoCellItem(item: $0)
        }.subscribe(onNext: { [weak self] item in
            self?.output.items.accept([item])
        }).disposed(by: disposeBag)
    }
}

