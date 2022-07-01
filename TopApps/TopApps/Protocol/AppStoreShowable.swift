//
//  AppStoreShowable.swift
//  TopApps
//
//  Created by APPSPIA on 2022/06/30.
//

import Foundation
import StoreKit

protocol AppStoreShowable {}

extension AppStoreShowable {
    func showAppStore(appId: String, sender: UIViewController) {
        let storeProductViewController = SKStoreProductViewController()
        storeProductViewController.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: appId], completionBlock: nil)
        sender.present(storeProductViewController, animated: true)
    }
}
