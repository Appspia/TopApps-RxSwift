//
//  API.swift
//  TopApps
//
//  Created by APPSPIA on 2022/05/18.
//

import Foundation
import ASNetworking
import RxSwift

enum AppListType: String {
    case free = "topfreeapplications"
    case paid = "toppaidapplications"
    case grossing = "topgrossingapplications"
}

enum API<T: Codable>: ASNetworking {
    case topApps(type: AppListType)
}

extension API {
    var request: Observable<T> {
        let requestData: ASRequestData
        switch self {
        case .topApps(let type):
            requestData = ASRequestData(urlString: server.rawValue + "/US/rss/\(type.rawValue)/limit=100/json", httpMethod: .get)
        }
        return httpRequestRx(requestData: requestData, isLogging: false)
    }
}
