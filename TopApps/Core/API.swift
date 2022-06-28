//
//  API.swift
//  TopApps
//
//  Created by APPSPIA on 2022/05/18.
//

import Foundation
import Alamofire
import RxSwift

public struct Response {}

enum APIError: Error {
    case httpError(Data?, HTTPURLResponse?, Error?)
}

enum API: String {
    case dev
    case staging
    case production
}

extension API {
    var baseUrl: String {
        switch self {
        case .dev:
            return "https://itunes.apple.com"
        case .staging:
            return "https://itunes.apple.com"
        case .production:
            return "https://itunes.apple.com"
        }
    }
    
    var commonHeader: HTTPHeaders {
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        return header
    }
}

extension API {
    func rxHttpRequest<T: Codable>(request: DataRequest) -> Single<T> {
        return Single<T>.create { single -> Disposable in
            request.responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let item):
                    single(.success(item))
                case .failure(let error):
                    single(.failure(APIError.httpError(response.data, response.response, error)))
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
