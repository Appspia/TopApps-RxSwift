//
//  ViewModel.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/10.
//

import Foundation
import RxSwift

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    var disposeBag: DisposeBag { get set }
}
