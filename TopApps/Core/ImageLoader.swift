//
//  ImageLoader.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/10.
//

import Foundation
import RxSwift
import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    
    lazy var cacheURLSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = URLCache.shared
        return URLSession(configuration: configuration)
    }()
    
    func loadImage(url: URL) -> Observable<UIImage> {
        return Observable<UIImage>.create { [weak self] observer in
            var dataTask: URLSessionDataTask?
            let cachedRequest = URLRequest(url: url, cachePolicy: .returnCacheDataDontLoad)
            if let cachedResponse = URLCache.shared.cachedResponse(for: cachedRequest), let image = UIImage(data: cachedResponse.data) {
                observer.onNext(image)
                observer.onCompleted()
            } else {
                dataTask = self?.cacheURLSession.dataTask(with: URLRequest(url: url)) { data, response, error in
                    if let data = data, let image = UIImage(data: data){
                        observer.onNext(image)
                        observer.onCompleted()
                    } else {
                        observer.onError(APIError.httpError(data, response as? HTTPURLResponse, error))
                    }
                }
                dataTask?.resume()
            }
            return Disposables.create() {
                dataTask?.cancel()
            }
        }.observe(on: MainScheduler.instance)
    }
}
