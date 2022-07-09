//
//  ASNetworking+RxSwift.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/29.
//

import Foundation
import ASNetworking
import RxSwift
import RxCocoa

enum APIError: Error {
    case httpError(Data?, HTTPURLResponse?, Error?)
}

extension ASNetworking {
    func httpRequestRx<T: Codable>(requestData: ASRequestData, isLogging: Bool) -> Observable<T> {
        return Observable<T>.create { observer in
            let response = httpRequest(requestData: requestData).response { (result: ASHttpResult<T>) in
                switch result {
                case .success(let item):
                    observer.onNext(item)
                    observer.onCompleted()
                case .failure(let data, let response, let error):
                    observer.onError(APIError.httpError(data, response, error))
                }
            }
            if isLogging {
                response.log()
            }
            return Disposables.create {
                response.sessionTask?.cancel()
            }
        }
    }
}
